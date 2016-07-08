class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_imageable
  before_action :user_owner!, only: [:show]

  def show
    render layout: !request.xhr?
  end

  def default
    respond_to do |format|
      @image.make_default!(current_user)
      format.js   {}
    end
  end

  private

  def set_imageable
    @image = Image.find(params[:id])
  end

  def user_owner!
    authenticate_user!

    if @image.user != current_user
      render js: "alert('You are not allowed to do this!');"
    end
  end
end
