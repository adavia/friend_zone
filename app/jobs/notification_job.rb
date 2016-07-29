class NotificationJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast "web_notification_#{notification.recipient_id}_channel",
      notification: render_notification(notification)
  end

  private

  def render_notification(notification)
    ApplicationController.render partial: "notifications/notification",
      locals: { notification: notification }, formats: [:html]
  end
end
