class SessionsController < ApplicationController
  def new; end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログイン成功'
    else
      flash.now.alert = 'メールまたはパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redicert_to root_url, notice: 'ログアウトしました。'
  end
end
