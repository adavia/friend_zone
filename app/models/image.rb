class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :post, optional: true
end
