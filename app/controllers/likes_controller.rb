class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likable

  def create
    @like = @likable.likes.build(user: current_user)
    @like.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @like = @likable.likes.find_by_user_id(current_user)
    @like.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def set_likable
    klass = [Image, Post].detect { |c| params["#{c.name.underscore}_id"] }
    @likable = klass.find(params["#{klass.name.underscore}_id"])
  end
end
