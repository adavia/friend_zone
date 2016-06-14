class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :gender, inclusion: { in: %w(male female),
    message: "%{value} is not a valid gender" }
  validates :birthday, presence: true
  validate  :birthday_cannot_be_greater_than_today

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def birthday_cannot_be_greater_than_today
    if birthday > Time.now
      errors.add(:birthday, "can't be greater than current date")
    end
  end

  def to_s
    email
  end

  def like?(model)
    self.likes.find_by_likable_id_and_likable_type(model, model.class.name)
  end
end
