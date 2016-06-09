class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable

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

  def destroy
    @comment = @commentable.comments.find_by_user_id(current_user)
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

  def comment_params
    params.require(:comment).permit(:body)
  end
end
