class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :post_owner!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:user, :images, :likes).all
    @post = current_user.posts.build
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

  def post_owner!
    authenticate_user!

    if @post.user != current_user
      render js: "alert('You are not allowed to do this!');"
    end
  end

  def upload_files
    if params[:images_attributes]
      params[:images_attributes].each do |image|
        @post.images.create(file: image[:file])
      end
    end
  end

  def post_params
    params.require(:post).permit(:body, images_attributes: [:file])
  end
end
