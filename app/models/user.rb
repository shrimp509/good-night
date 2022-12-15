class User < ApplicationRecord
  has_many :be_followeds, foreign_key: :followed_id, class_name: 'Follow'
  has_many :followers, through: :be_followeds, source: :follower
  
  has_many :follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followeds, through: :follows, source: :followed

  has_many :clock_ins

  def sleep_times_from_days_ago(days_ago = 7)
    clockins = clock_ins.where("created_at > ? and created_at < ?", days_ago.days.ago, Time.current)
    sleep_times = SleepCalculator.new(clockins).start
  end

  def follow(user)
    Follow.create(followed: user, follower: self)
  end

  def unfollow(user)
    Follow.find_by(followed: user, follower: self)&.destroy
  end
end
