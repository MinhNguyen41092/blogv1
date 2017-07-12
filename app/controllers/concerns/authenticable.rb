module Authenticable

  def generate_auth_token user
    payload = {id: user.id, email: user.email, password: user.password_digest}
    JsonWebToken.encode payload
  end

  def current_user
    @current_user ||= User.find_by auth_token: request.headers["Authorization"]
  end

  def authenticate_by_token
    render json: {errors: "Unauthorized user"},
      status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end
end
