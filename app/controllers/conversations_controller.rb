class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  def index
    @conversations = Conversation.all
  end

  def show
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