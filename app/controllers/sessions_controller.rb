class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:notice] = t('sessions.create.success') # :success を :notice に変更
      redirect_to mypage_path
    else
      flash.now[:alert] = t('sessions.create.failure') # :error を :alert に変更
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:notice] = t('sessions.destroy.success') # :success を :notice に変更
    redirect_to root_path, status: :see_other
  end
end
