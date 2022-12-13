class ApplicationController < ActionController::API

  def success_response(data)
    render json: {data: data}, status: 200
  end

  def error_response(error_code, err_msg)
    render json: {err_msg: err_msg}, status: error_code
  end

  def current_user
    @user ||= User.find_by(id: params[:user_id])
    return error_response(404, 'User not found') if @user.nil?
    @user
  end
end
