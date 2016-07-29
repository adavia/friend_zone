class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  def show
    @messages = @conversation.messages.last(15)
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

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
