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
    # @post.sub_id = 
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
  end

  def edit
  
  end

  def update

  end

  def destroy

  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

end
