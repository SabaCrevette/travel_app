class UsersController < ApplicationController
  def index
    # 現在のユーザーの情報を取得するロジック
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
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
