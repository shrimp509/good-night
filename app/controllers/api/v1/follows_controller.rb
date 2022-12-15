class Api::V1::FollowsController < ApplicationController
  before_action :current_user

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

  def sleep_ranking
    result = current_user.followeds.map do |user|
                user.as_json.merge(total_sleep_times: user.sleep_times_from_days_ago)
              end.sort_by { |h| h[:total_sleep_times] }.reverse!
    success_response(result)
  end
end
