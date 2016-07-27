json.array! @notifications do |notification|
  json.id notification.id
  json.unread !notification.read_at?
  json.template render partial: "notification", locals: {notification: notification}, formats: [:html]



  #json.sender notification.sender.username
  #json.action notification.action
  #json.notifiable do
    #json.type "your #{notification.notifiable.class.to_s.downcase}"
    #json.path polymorphic_path(notification.notifiable)
  #end
end
