class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :post, optional: true

  belongs_to :user, optional: true

  has_many :likes, as: :likable, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy

  self.per_page = 12

  def make_default!(user)
    Image.where(user: user).update_all(default: false)
    update!(default: true)
  end

  def self.default
    find_by(default: true)
  end
end
