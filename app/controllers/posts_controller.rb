class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :post_owner!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.
      where(user: current_user.timeline_user_ids).
      includes(:user, :images, :likes).paginate(page: params[:page])
    @post = current_user.posts.build

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        upload_files
        format.js   {}
        format.json {
          render json: @post, status: :created, location: @post
        }
      else
        format.js   {}
        format.json {
          render json: @post.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def edit
  end

  def update
    whitelisted_params = post_params
    whitelisted_params.delete(:images_attributes)

    respond_to do |format|
      if @post.update(whitelisted_params)
        format.js   {}
        format.json {
          render json: @post, status: :created, location: @post
        }
      else
        format.js   {}
        format.json {
          render json: @post.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.js {}
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def upload_files
    images = params[:images][:file].reject(&:blank?)

    if images
      images.each do |image|
        @post.images.create!(file: image, user_id: current_user.id)
      end
    end
  end

  def post_owner!
    authenticate_user!

    if @post.user != current_user
      render js: "You are not allowed to do this!"
    end
  end

  def post_params
    params.require(:post).permit(:body, images_attributes: [:file, :user_id])
  end
end
