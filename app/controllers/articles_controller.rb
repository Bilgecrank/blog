class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "admin",
                               password: "secret",
                               except: %i[index show]
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

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
