# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, except: %i[index new create]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = posts_query(Post.accessible_by(current_ability).order(created_at: :desc))
    @pagy, @posts = pagy(@posts, items: 20)
  end

  def show; end

  def edit; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = I18n.t('posts.create_success')
      redirect_to @post
    else
      flash.now[:error] = @post.errors.full_messages
      render_flash
    end
  end

  def update
    if @post.update(post_params)
      flash.now[:success] = I18n.t('posts.update_success')
      redirect_to @post
    else
      flash.now[:error] = @post.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = I18n.t('posts.destroy_success')
      redirect_to posts_path
    else
      render_general_error
    end
  end

  private

  def posts_query(posts)
    posts
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
