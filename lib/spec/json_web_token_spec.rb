require 'rails_helper'
require 'jwt'

describe JsonWebToken do
  before :each do
    payload = {data: "test"}
    @token = JsonWebToken.encode payload, exp = 24.hours.from_now
  end

  describe "encode function" do
    it "should encode data" do
      expect(@token).to be_kind_of String
    end

    it "should have 3 segments in token" do
      segments = @token.split "."
      expect(segments.size).to eql 3
    end
  end

  describe "decode token" do
    before :each do
      data = JsonWebToken.decode(@token)
      @payload = data[0].symbolize_keys
    end

    it "should decode token to correct data" do
      expect(@payload[:data]).to eql "test"
      expect(@payload[:exp]).to eql 24.hours.from_now.to_i
    end
  end
end
