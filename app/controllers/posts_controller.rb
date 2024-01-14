class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index show]

  # /search
  def index
    @user_prefectures = UserPrefecture.all

    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user, :prefecture, :tags).order(created_at: :desc)

    if params[:exclude_unvisited_prefectures] == 'true'
      visited_prefecture_ids = current_user.posts.select(:prefecture_id).distinct.pluck(:prefecture_id)
      @posts = @posts.where.not(prefecture_id: visited_prefecture_ids)
    end

    @context = 'posts'
  end

  # @posts = if (tag_name = params[:tag_name])
  #            # タグ名に基づいて投稿を取得し、関連するユーザー、都道府県、タグを事前読み込み
  #            Post.with_tag(tag_name).includes(:user, :prefecture, :tags).order(created_at: :desc)
  #          else
  #            # すべての投稿を取得し、関連するユーザー、都道府県、タグを事前読み込み
  #            Post.includes(:user, :prefecture, :tags).order(created_at: :desc)
  #          end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    TagAssigner.new(@post, extracted_tag_names).assign_new

    if @post.save
      flash[:notice] = t('defaults.flash.created', item: Post.model_name.human)
      redirect_to search_path
    else
      flash.now[:alert] = t('defaults.flash.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

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
    post = current_user.posts.find(params[:id])
    post.destroy!
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:location, :prefecture_id, :text, :event_status, :public_status, { images_cache: [] }, { images: [] })
  end

  # タグの名前を取得し、分割して処理
  def extracted_tag_names
    params[:post][:tag_names].to_s.split(/,\s*|\s+|\u3000+/).map(&:strip)
  end
end
