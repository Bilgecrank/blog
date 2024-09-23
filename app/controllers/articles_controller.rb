class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    if params[:id] =~ /\A\d+\z/ ? true : false
      @article = Article.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
