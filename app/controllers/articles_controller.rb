class ArticlesController < ApplicationController
  before_action :find_user, only: [:show, :new, :create, :edit, :update]

  def index
    if params[:user_id]
      @articles = User.find(params[:user_id]).articles.order(created_at: :desc)
    else
      @articles = Article.all.order(created_at: :desc)
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @user.articles << Article.create!(article_params)
    if @user.save
      flash[:notice] = 'New Article Submitted!'
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages.join(' ')
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    @article = article.update_attributes(article_params)
    redirect_to action: :index
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end