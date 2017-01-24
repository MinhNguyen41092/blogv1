class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_admin, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
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