class ApplicationController < ActionController::API

  def success_response(data)
    render json: {data: data}, status: 200
  end

  def error_response(error_code, err_msg)
    render json: {err_msg: err_msg}, status: error_code
  end
end
