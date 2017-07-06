require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do

  describe "Get #show" do
    before :each do
      @article = FactoryGirl.create :article
      get :show, id: @article.id, format: :json
    end

    it "should return the information in a hash" do
      article_response = JSON.parse response.body, symbolize_names: true
      expect(article_response[:attributes][:name]).to eql @article.name
    end

    it { should respond_with 200 }
  end

  describe "Get #index" do
    before :each do
      5.times { FactoryGirl.create :article }
      get :index, format: :json
    end

    it "should return the information in a hash" do
      article_response = JSON.parse response.body, symbolize_names: true
      expect(article_response[:attributes].size).to eql 5
    end

    it { should respond_with 200 }
  end
end
