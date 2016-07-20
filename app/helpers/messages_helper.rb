module MessagesHelper
  def self_or_other(message)
    message.user == current_user ? "left" : "right"
  end
end
