class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :set_user, only: :create

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post created."
      render 'show'
    else
      # Find cleaner way to display errors
      flash[:danger] = "Post failed. Please try again."
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def post_params
      params.require(:post).permit(:user_id, :title, :content)
    end

    def set_user
      params[:post][:user_id] = current_user.id
    end
end
