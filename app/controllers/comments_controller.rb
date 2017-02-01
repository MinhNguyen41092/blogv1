class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save 
      flash[:success] = "Your comment has been added"
      redirect_to article_path(@article)
    else
      redirect_to :back
    end
  end
 
  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end