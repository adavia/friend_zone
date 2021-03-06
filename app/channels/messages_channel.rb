# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_#{params['conversation_id']}_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
