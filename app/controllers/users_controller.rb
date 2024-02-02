class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def index
    @posts = current_user.posts.includes(:prefecture, :tags).order(created_at: :desc)
    @user_prefectures = UserPrefecture.where(user_id: current_user.id)
    @context = 'posts'
    @tag_recommend = RecommendPostQuery.new(current_user).call
    @prefecture_recommend = RecommendPrefectureQuery.new(current_user).call
    @category_recommend = RecommendCategoryQuery.new(current_user).call
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      flash[:notice] = t('users.create.success')
      redirect_to mypage_path
    else
      flash.now[:alert] = t('users.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # params[:username] を使って、特定のユーザーを見つけるロジック
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
