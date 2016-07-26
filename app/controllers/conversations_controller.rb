class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  def index
    @conversations = Conversation.joins(:messages).
      involving(current_user).
      order("messages.created_at DESC").
      to_a.uniq

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @messages = @conversation.messages.last(15)
    render layout: !request.xhr?
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.
        between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    respond_to do |format|
      format.json {
        render json: { conversation_id: @conversation.id }
      }
    end
  end

  private

  def set_conversation
    @conversation = Conversation.includes(:messages).find(params[:id])
  end

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
