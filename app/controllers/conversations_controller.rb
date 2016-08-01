class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]
  before_action :conversation_owner!, only: [:show]

  def index
    @conversations = Conversation.joins(:messages).
      involving(current_user).
      group("conversations.id").
      order("max(messages.created_at) DESC")
  end

  def show
    @messages = @conversation.messages.order(created_at: :DESC).limit(12).reverse
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.
        between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    respond_to do |format|
      format.html {
        redirect_to @conversation
      }
    end
  end

  private

  def set_conversation
    @conversation = Conversation.includes(:messages).find(params[:id])
  end

  def conversation_owner!
    authenticate_user!

    if ![@conversation.sender, @conversation.recipient].include? current_user
      render js: "alert('You are not allowed to do this!')"
    end
  end

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
