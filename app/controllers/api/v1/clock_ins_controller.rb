class Api::V1::ClockInsController < ApplicationController
  before_action :current_user

  def index
    success_response(current_user.clock_ins.order(created_at: :desc))
  end

  def create
    clock_in = ClockIn.create(user: current_user)
    return error_response(400, 'Fail to clock in for some reason') unless clock_in
    index
  end

  private

  def current_user
    @user ||= User.find_by(id: params[:user_id])
    return error_response(404, 'User not found') if @user.nil?
    @user
  end
end
