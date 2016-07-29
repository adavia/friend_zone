class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_notifications, if: :user_signed_in?
  before_action :set_messages, if: :user_signed_in?

  def set_notifications
    @notifications = Notification.where(recipient: current_user).recent
  end

  def set_messages
    conversations = Conversation.includes(:messages).involving(current_user)
    conversations.each do |conversation|
      @notifications_messages = conversation.messages.recent(current_user)
    end
  end
end
