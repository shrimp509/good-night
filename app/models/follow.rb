class Follow < ApplicationRecord
  belongs_to :followed, class_name: 'User', foreign_key: :followed_id
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id

  validate :already_followed, on: [:create, :update]
  validate :follow_self, on: [:create, :update]

  private

  def already_followed
    errors.add(:base, :invalid, message: 'Already followed') if Follow.find_by(followed: followed, follower: follower)
  end

  def follow_self
    errors.add(:base, :invalid, message: 'Cannot follow yourself') if followed.id == follower.id
  end
end
