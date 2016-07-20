class Post < ApplicationRecord
  belongs_to :user

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  has_many :likes, as: :likable, dependent: :destroy
  validates_length_of :images, maximum: 3, message: "You can upload 3 files max."

  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { maximum: 800 }
  validates :user, presence: true

  default_scope -> { order(created_at: :desc) }

  self.per_page = 12
end
