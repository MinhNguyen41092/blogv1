require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should respond_to :username}
    it {should respond_to :email}
    it {should respond_to :password_digest}
    it {should respond_to :auth_token}
    it {should validate_uniqueness_of :auth_token}
  end
end
