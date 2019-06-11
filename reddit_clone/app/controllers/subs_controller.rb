class SubsController < ApplicationController

  before_action :require_login

  before_action :require_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
  end

  def update
    @sub = current_user.subs.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end


  private

  def require_moderator
    # Check to see current user is a moderator for current sub
    # Map Subs Array by object id, then check whether array includes current sub id
    if !current_user.subs.map(&:id).include?(params[:id])
      flash[:errors] = ["User is not a moderator for current sub!"]
      redirect_to sub_url(params[:id])
    end
    
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end


end
