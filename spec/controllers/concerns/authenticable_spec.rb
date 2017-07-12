require 'rails_helper'
require 'jwt'

class Authentication < ActionController::Base
  include Authenticable
end

describe Authenticable do
  let :authentication {Authentication.new}
  subject {authentication}

  before :each do
    @user = FactoryGirl.create :user
    @user.auth_token = authentication.generate_auth_token @user
    @user.save
  end

  describe "generate auth token" do
    context "encode token" do
      it "should generate auth token" do
        expect(@user.auth_token).to_not be nil
      end

      it "should have correct format" do
        expect(@user.auth_token.split('.').size).to eql 3
      end
    end

    context "decode token" do
      before :each do
        @data = JsonWebToken.decode(@user.auth_token).first.symbolize_keys
      end

      it "should have correct data" do
        expect(@data[:id]).to eql @user.id
        expect(@data[:email]).to eql @user.email
      end
    end
  end

  describe "current user" do
    before :each do
      # request method only available in controllers test
      request.headers["Authorization"] = @user.auth_token
      # create mock method request, to avoid using real request
      # it works by return a value whenever a request method of authentication is called
      authentication.stub(:request).and_return request
    end

    it "should return correct user" do
      expect(authentication.current_user).to eql @user
    end

    context "render errors when not sign in" do
      before :each do
        authentication.stub(:current_user).and_return nil
        response.stub(:response_code).and_return 401
        response.stub(:body).and_return({errors: "Unauthorized user"}.to_json)
        authentication.stub(:response).and_return response
      end

      it "should render errors" do
        expect(json_response[:errors]).to be_present
      end

      it {should respond_with 401}
    end
  end
end
