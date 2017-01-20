class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created successfully"
      session[:user_id] = @user_id
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def show
    
  end
  
  private
  
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def require_same_user
      if current_user != @user 
        flash[:danger] = "You can not edit other people profile"
        redirect_to root_path
      end
    end
  
end