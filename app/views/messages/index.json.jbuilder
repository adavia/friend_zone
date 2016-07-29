json.array! @notifications_messages do |message|
  json.id message.id
  json.unread !message.read_at?
  json.template render(partial: "messages/notification", locals: {message: message}, formats: [:html])
end
