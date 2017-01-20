class ArticlesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    session[:current_article_id] = @article.id
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    
    if @article.save
      flash[:success] = "Your article has been saved"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit 
    
  end
  
  def update 
    
  end
  
end