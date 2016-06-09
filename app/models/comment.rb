class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true
  validates :body, length: { maximum: 300 }
  validates :commentable, presence: true

  default_scope -> { order(created_at: :asc) }
end
