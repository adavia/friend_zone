class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope :involving, -> (user) do
    where(sender: user.id).
    or(where(recipient: user.id)).
    limit(10)
  end

  scope :between, -> (sender_id, recipient_id) do
    where(sender: sender_id).
    where(recipient: recipient_id).
    or(where(sender: recipient_id).
    where(recipient: sender_id))
  end
end
