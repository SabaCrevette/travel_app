class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index show]

  DEFAULT_TEXT = I18n.t('posts.default_text').freeze

  # /search
  def index
    @text = DEFAULT_TEXT
    @q = Post.ransack(params[:q])
    @posts = load_posts
    @context = 'posts'

    # 全ユーザーの投稿を都道府県ごとに集計
    posts_count_by_prefecture = Post.group(:prefecture_id).count

    # 集計結果をもとに、@user_prefectures に格納するデータ構造を作成
    @user_prefectures = posts_count_by_prefecture.map do |prefecture_id, count|
      OpenStruct.new(prefecture_id:, post_count: count)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    TagAssigner.new(@post, extracted_tag_names).assign_new

    if @post.save
      flash[:notice] = t('defaults.flash.created', item: Post.model_name.human)
      redirect_to post_path(@post)
    else
      flash.now[:alert] = t('defaults.flash.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    return if post_opened_and_current_user_owned?

    flash[:alert] = t('posts.not_found')
    redirect_to search_path and return
  end

  # GET /posts/1/edit
  def edit; end

  def update
    # TagAssigner サービスを使用してタグを割り当てる
    TagAssigner.new(@post, extracted_tag_names).assign_with_removal

    if @post.update(post_params)
      flash[:notice] = t('defaults.flash.updated', item: Post.model_name.human)
      redirect_to post_path(@post)
    else
      flash.now[:alert] = t('defaults.flash.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    flash[:notice] = t('defaults.flash.deleted', item: Post.model_name.human)
    redirect_to search_path, status: :see_other
  end

  def bookmarks
    @user_prefectures = UserPrefecture.all
    # ブックマーク一覧を取得
    @bookmark_posts = current_user.bookmark_posts.includes(:user, :prefecture, :tags).order(created_at: :desc)
    # タグに基づいて絞り込み
    @bookmark_posts = @bookmark_posts.with_tag(params[:tag_name]).order(created_at: :desc) if params[:tag_name].present?
    @context = 'bookmarks'
  end

  def toggle_partial
    if params[:checked] == 'true'
      # トグルONの時、現在のユーザーの投稿に基づくデータ
      @user_prefectures = UserPrefecture.where(user_id: current_user.id)
      @text = "#{current_user.name}さん"
    else
      # トグルOFFの時、全ユーザーの投稿数に基づくデータをUserPrefectureオブジェクトとして構築
      post_counts = Post.group(:prefecture_id).count
      @user_prefectures = post_counts.map do |prefecture_id, count|
        OpenStruct.new(prefecture_id:, post_count: count)
      end
      @text = DEFAULT_TEXT
    end

    render partial: 'users/japanmap', locals: { user_prefectures: @user_prefectures, text: @text }
  end

  def autocomplete_location
    @locations = Post.select('DISTINCT location').where('location LIKE ?', "%#{params[:q]}%").limit(5)
    render partial: 'posts/autocompletes/location', locals: { locations: @locations }
  end

  def autocomplete_text
    @texts = Post.select('DISTINCT text').where('text LIKE ?', "%#{params[:q]}%").limit(5)
    render partial: 'posts/autocompletes/text', locals: { texts: @texts }
  end

  def autocomplete_tag_name
    @tag_names = Tag.select('DISTINCT name').where('name LIKE ?', "%#{params[:q]}%").limit(5)
    render partial: 'posts/autocompletes/tag_name', locals: { tag_names: @tag_names }
  end

  def load_posts
    @q = Post.ransack(params[:q])
    @posts = @q.result # `distinct: true`を省略
    @posts = @posts.with_tag(params[:tag_name]) if params[:tag_name].present?
    @posts = @posts.exclude_unvisited_prefectures(current_user) if params[:exclude_unvisited_prefectures] == 'true'
    @posts = @posts.by_status(current_user)
    @posts = @posts.order(created_at: :desc).page(params[:page]) # ページネーション
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to search_path, alert: t('posts.not_found')
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:location, :prefecture_id, :text, :event_status, :public_status, { images_cache: [] }, { images: [] })
  end

  # タグの名前を取得し、分割して処理
  def extracted_tag_names
    params[:post][:tag_names].to_s.split(/,\s*|\s+|\u3000+|、/).map(&:strip)
  end

  def post_opened_and_current_user_owned?
    !(@post.closed? && (current_user.nil? || @post.user_id != current_user.id))
  end
end
