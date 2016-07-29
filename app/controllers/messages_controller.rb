class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:create]

  def create
    message = @conversation.messages.build(message_params)
    message.user = current_user
    message.save

    head :ok
  end

  def read
    @conversations = Conversation.includes(:messages).involving(current_user)
    @conversations.each do |conversation|
      messages = conversation.messages.recipient_unread(current_user)
      messages.update_all(read_at: Time.zone.now) if messages.any?
    end

    render json: { success: true }
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
