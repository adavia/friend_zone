class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
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

  private

  def upload_files
    if params[:images] && params[:images] != [""]
      params[:images].each do |image|
        @post.images.create(file: image)
      end
    end
  end

  def post_params
    params.require(:post).permit(:body, :images)
  end
end
