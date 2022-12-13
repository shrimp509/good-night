class User < ApplicationRecord
  has_many :be_followeds, foreign_key: :followed_id, class_name: 'Follow'
  has_many :followers, through: :be_followeds, source: :follower
  
  has_many :follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followeds, through: :follows, source: :followed

  has_many :clock_ins
end
