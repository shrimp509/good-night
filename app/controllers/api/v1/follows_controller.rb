class Api::V1::FollowsController < ApplicationController
  before_action :current_user, except: [:index]

  def create
    followed = User.find_by(id: params[:follow_id])
    return error_response(400, 'User has been followed') if current_user.followeds.include?(followed)
    current_user.followeds << followed
    success_response('Follow success')
  end

  def unfollows
    unfollowed = User.find_by(id: params[:unfollow_id])
    follow_record = current_user.follows.find_by(followed: unfollowed)
    return error_response(400, 'User is not followed') unless follow_record
    follow_record.destroy
    success_response('Unfollow success')
  end
end
