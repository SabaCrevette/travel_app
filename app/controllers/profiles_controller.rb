class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = t('defaults.flash.updated', item: User.model_name.human)
      redirect_to profile_path
    else
      flash.now['alert'] = t('defaults.flash_message.not_updated', item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avata_cache)
  end
end
