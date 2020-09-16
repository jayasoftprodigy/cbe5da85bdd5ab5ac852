class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :questions
  has_many :answers

  def topics
    topics = FollowTopic.where(user_id: self.id).pluck(:topic_id)
    Topic.where(id: topics)
  end

  def following
    users = FollowUser.where(user_id: self.id).pluck(:follow_id)
    User.where(id: users)
  end
end
