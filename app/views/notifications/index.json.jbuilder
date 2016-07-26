json.array! @notifications do |notification|
  json.sender notification.sender.username
  json.action notification.action
  json.notifiable do
    json.type "your #{notification.notifiable.class.to_s.downcase}"
    json.path polymorphic_path(notification.notifiable)
  end
end
