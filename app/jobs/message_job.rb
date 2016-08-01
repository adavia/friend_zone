class MessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "conversation_#{message.conversation.id}_channel",
      message: render_message(message)

    ActionCable.server.broadcast "web_notification_#{recipient(message)}_channel",
      message: message.body
  end

  private

  def render_message(message)
    ApplicationController.render partial: "messages/message",
      locals: { message: message }, formats: [:html]
  end

  def recipient(message)
    if message.user == message.conversation.recipient
      message.conversation.sender.id
    else
      message.conversation.recipient.id
    end
  end
end
