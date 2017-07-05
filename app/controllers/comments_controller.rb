class CommentsController < ApplicationController
  before_action :require_user
  before_action :admin_user, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Your comment has been added"
      respond_to do |format|
        format.html { redirect_to article_path(@article) }
        format.js # render comments/create.js.erb
      end

    else
      flash[:danger] = "Comment could not be saved"
      redirect_to :back
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment has been deleted"
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
