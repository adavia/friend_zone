class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :images

  has_many :subscriptions, foreign_key: :follower_id,
    dependent: :destroy

  has_many :leaders, through: :subscriptions

  has_many :reverse_subscriptions, foreign_key: :leader_id,
    class_name: 'Subscription', dependent: :destroy

  has_many :followers, through: :reverse_subscriptions

  validates :username, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :gender, inclusion: { in: %w(male female),
    message: "%{value} is not a valid gender" }
  validates :address, presence: true
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
    username
  end

  def timeline_user_ids
    leader_ids + [id]
  end

  def like?(model)
    self.likes.find_by_likable_id_and_likable_type(model, model.class.name)
  end

  def age
    now = Time.now.utc.to_date
    now.year - self.birthday.year - ((now.month > self.birthday.month ||
     (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end

  def following?(leader)
    leaders.include? leader
  end

  def follow!(leader)
    if leader != self && !following?(leader)
      leaders << leader
    end
  end

  def unfollow!(leader)
    if leader != self && following?(leader)
      leaders.delete(leader)
    end
  end
end
