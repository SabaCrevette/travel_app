require 'debug'

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index show]

  # /search
  def index
    @posts = Post.includes(:user, :prefecture).all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:location, :prefecture_id, :text, :event_status, :public_status, { images_cache: [] }, { images: [] })
  end
end
