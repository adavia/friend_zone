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
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.js   {}
        format.json {
          render json: @message, status: :created, location: @message
        }
      else
        format.js   {}
        format.json {
          render json: @message.errors, status: :unprocessable_entity
        }
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
