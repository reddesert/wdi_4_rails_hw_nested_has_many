class CommentsController < ApplicationController

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def show
  end

  def new
    @article = Article.find(params[:article_id])
    @user = User.find(params[:user_id])
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.create!(comment_params)
    @article.comments << @comment
    if @article.save
      flash[:notice] = "New Comment Added!"
      redirect_to action: :index
    else
      flash.now[:error] = @comment.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end