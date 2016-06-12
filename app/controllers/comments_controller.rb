class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: [:index, :new, :create, :edit, :update]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :comment_owner!, only: [:edit, :update, :destroy]

  def index
    @comments = @commentable.comments
      .paginate(page: params[:page])
      .order(created_at: :desc)

    respond_to do |format|
      format.js   {}
      format.json {
        render json: @comments
      }
    end
  end

  def new
    @comment = @commentable.comments.build
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.js   {}
        format.json {
          render json: @comment, status: :created, location: @comment
        }
      else
        format.js   {}
        format.json {
          render json: @comment.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
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
    @comment.destroy

    respond_to do |format|
      format.js {}
    end
  end

  private

  def set_commentable
    klass = [Post, Image].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_owner!
    authenticate_user!

    if @comment.user != current_user
      render js: "alert('You are not allowed to do this!');"
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
