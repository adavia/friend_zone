class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy

  def to_s
    email
  end

  def like?(model)
    self.likes.find_by_likable_id_and_likable_type(model, model.class.name)
  end
end
