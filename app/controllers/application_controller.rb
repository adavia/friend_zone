class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_unread_notifications, if: :user_signed_in?
  before_action :set_unread_conversations, if: :user_signed_in?

  def set_unread_notifications
    @unread_notifications = Notification.where(recipient: current_user).unread.count
  end

  def set_unread_conversations
    @unread_conversations = Conversation.joins(:messages).
    involving(current_user).
    where.not(messages: { user_id: current_user }).
    where(messages: { read_at: nil }).count
  end
end
