class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def index
    @messages = @conversation.messages

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user != current_user
        @messages.last.read = true;
      end
    end
  end

  def create
    message = @conversation.messages.build(message_params)
    message.user = current_user
    message.save

    ActionCable.server.broadcast "conversation_#{message.conversation.id}_channel",
      message: render_message(message)

    head :ok
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def render_message(message)
    render partial: "messages/message", locals: { message: message }
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
