class PostsController < ApplicationController

  before_action :require_login

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
     
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: parmas[:id])
    if @post
      @post.destroy
      redirect_to subs_url
    else
      flash[:errors] = ["You have no permission to delete this post."]
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

end
