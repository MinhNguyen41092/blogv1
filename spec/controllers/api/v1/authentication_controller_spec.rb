require 'rails_helper'
require 'jwt'
include Authenticable

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  before do
    @user = FactoryGirl.create :user
    credentials = {email: @user.email, password: @user.password}
    post :create, params: credentials, format: :json
    @user.reload
  end

  describe "post #create" do
    context "success" do
      it "should create auth token for user" do
        expect(@user.auth_token).to_not be nil
      end

      it "should send back auth_token to user" do
        auth_response = json_response
        expect(auth_response[:attributes][:auth_token].split('.').size).to eql 3
      end

      it { should respond_with 200 }
    end

    context "failed" do
      before do
        credentials = {email: "", password: ""}
        post :create, params: credentials, format: :json
        @user.reload
      end

      it "should not send back auth token to user" do
        auth_response = json_response
        expect(json_response[:errors]).to match "Incorrect email
        or password"
      end

      it { should respond_with 422 }
    end
  end

  describe "delete #destroy" do
    context "success" do
      before do
        request.headers["Authorization"] = @user.auth_token
        delete :destroy, id: @user.id
        @user.reload
      end

      it "should delete auth token" do
        expect(@user.auth_token).to be nil
      end

      it "should send back correct message" do
        expect(json_response[:message]).to match "You have logged out"
      end

      it { should respond_with 200 }
    end

    context "failed" do
      before do
        request.headers["Authorization"] = @user.auth_token
        delete :destroy, id: 20
        @user.reload
      end

      it "should not delete user auth token" do
        expect(@user.auth_token).to_not be nil
      end

      it "should send back correct message" do
        expect(json_response[:errors]).to match "Incorrect credentials"
      end

      it { should respond_with 422 }
    end
  end
end
