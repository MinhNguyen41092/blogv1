require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do

  describe "Get #show" do
    before :each do
      @article = FactoryGirl.create :article
      get :show, id: @article.id, format: :json
    end

    it "should return the information in a hash" do
      article_response = json_response
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
      article_response = json_response
      expect(article_response[:attributes].size).to eql 5
    end

    it { should respond_with 200 }
  end

  describe "Post #create" do
    context "success" do
      before :each do
        @article_params = FactoryGirl.attributes_for :article
        post :create, article: @article_params
      end

      it "should create new article" do
        article_response = json_response
        expect(article_response[:attributes][:name]).to eql @article_params[:name]
      end

      it { should respond_with 201 }
    end

    context "failed" do
      before :each do
        @article_params = FactoryGirl.attributes_for :article, name: ""
        post :create, article: @article_params
      end

      it "should not create new article" do
        article_response = json_response
        expect(article_response[:errors]).to be_present
      end

      it { should respond_with 422 }
    end
  end

  describe "Patch/PUT #update" do
    context "success" do
      before :each do
        @article = FactoryGirl.create :article
        patch :update, id: @article.id, article: {name: "Chieftain mk5"}
      end

      it "should update article" do
        article_response = json_response
        expect(article_response[:attributes][:name]).to eql "Chieftain mk5"
      end

      it { should respond_with 200 }
    end

    context "failed" do
      before :each do
        @article = FactoryGirl.create :article
        patch :update, id: @article.id, article: {name: ""}
      end

      it "should not update new article" do
        article_response = json_response
        expect(article_response[:errors]).to be_present
      end

      it { should respond_with 422 }
    end
  end
end
