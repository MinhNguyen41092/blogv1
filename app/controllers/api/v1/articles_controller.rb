module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: [:update, :show, :destroy]
      #before_action :require_user, except: [:show, :index, :like]
      #before_action :require_user_like, only: [:like]
      #before_action :require_admin, only: [:edit, :update]
      #before_action :admin_user, only: :destroy
      respond_to :json

      def index
        render json: {type: "articles", attributes: Article.all}
      end

      def show
        render json: {type: "articles", attributes: @article}
      end

      def create
        @article = Article.new article_params

        if @article.save
          render json: {status: 201, type: "articles", attributes: @article}, status: 201
        else
          render json: {status: 422, type: "articles", errors: @article.errors}, status: 422
        end
      end

      def update
        if @article.update article_params
          render json: {status: 200, type: "articles", attributes: @article}, status: 200
        else
          render json: {status: 422, type: "articles", errors: @article.errors}, status: 422
        end
      end

      def destroy
        Article.find(params[:id]).destroy
        flash[:success] = "Article has been deleted"
        redirect_to articles_path
      end


      private

      def article_params
        params.require(:article).permit :name, :body, :user_id
      end

      def set_article
        @article = Article.find params[:id]
      end

      def require_admin
        if !current_user.admin
          flash[:warning] = "Only admin can edit articles"
          redirect_to article_path(@article)
        end
      end

      def require_user_like
        if !logged_in?
          flash[:danger] = "You must be logged in to perform that action"
          redirect_to :back
        end
      end
    end
  end
end
