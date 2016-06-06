class Post < ApplicationRecord
  belongs_to :user

  has_many :images, as: :imageable, dependent: :destroy

  has_many :likes, as: :likable, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true

  default_scope -> { order(created_at: :desc) }
end
