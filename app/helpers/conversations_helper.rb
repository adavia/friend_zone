module ConversationsHelper
  def message_interlocutor(conv)
    current_user == conv.sender ? conv.recipient : conv.sender
  end
end
