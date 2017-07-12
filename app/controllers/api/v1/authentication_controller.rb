class Api::V1::AuthenticationController < ApplicationController
  include Authenticable

  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      user.auth_token = generate_auth_token user
      user.save
      render json: {status: 200, type: "Authorized", attributes: user}, status: 200
    else
      render json: {status: 422, type: "Unauthorized", errors: "Incorrect email
        or password"}, status: 422
    end
  end

  def destroy
    user = User.find_by id: params[:id]
    if user && user.auth_token = request.headers["Authorization"]
      user.auth_token = nil
      user.save
      render json: {status: 200, message: "You have logged out"}, status: 200
    else
      render json: {status: 422, type: "Unauthorized",
        errors: "Incorrect credentials"}, status: 422
    end
  end
end
