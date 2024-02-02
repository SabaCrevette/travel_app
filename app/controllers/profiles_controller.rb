class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :set_select_options, only: %i[edit update] # 追加
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

  # 追加
  def set_select_options
    @prefectures = Prefecture.all
    @categories = Category.all
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache, :prefecture_id, :category_id) # :prefecture_idと:category_idを追加
  end
end
