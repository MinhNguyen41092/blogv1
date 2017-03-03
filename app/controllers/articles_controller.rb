class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_admin, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  respond_to :html, :js
  
  def index
    @articles = Article.all
    if params[:search]
      @articles = Article.search(params[:search]).order("created_at DESC")
    else
      @articles = Article.all.order('created_at DESC')
    end
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
    if @article.update(article_params)
      flash[:success] = "Your article has been updated successfully"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end
  
  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Article has been deleted"
    redirect_to articles_path
  end
  
  
  private
  
    def article_params
      params.require(:article).permit(:name, :body)
    end
    
    def set_article
      @article = Article.find(params[:id])
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