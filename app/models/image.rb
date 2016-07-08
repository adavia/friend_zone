class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :post, optional: true

  belongs_to :user

  has_many :likes, as: :likable, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
end
