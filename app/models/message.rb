class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  scope :recipient_unread, -> (user) { where(read_at: nil).where.not(user: user) }

  after_commit -> { MessageJob.perform_later(self) }
end
