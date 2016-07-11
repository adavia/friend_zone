class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :user_owner!, only: [:follow, :unfollow]

  def show
    @posts = @user.posts.paginate(page: params[:page])
    @images = @user.images.paginate(page: params[:page])
  end

  def follow
    respond_to do |format|
      current_user.follow!(@user)
      format.js   {}
    end
  end

  def unfollow
    respond_to do |format|
      current_user.unfollow!(@user)
      format.js   {}
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_owner!
    authenticate_user!

    if @user == current_user
      render js: "alert('You are not allowed to do this!');"
    end
  end
end
