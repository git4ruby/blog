class ArticlesController < ApplicationController


  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id if current_user
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])

  end

  def update
    @article = Article.find(params[:id])


    if @article.user_id == current_user.id

      if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
      end
      flash[:notice]="Article edited successfully!"

    else
      redirect_to articles_path
      flash[:notice]="Cannot edit other user Article!"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.user_id == current_user.id
      @article.destroy
      flash[:notice]="Article deleted successfully!"
    else
      flash[:notice]="Cannot delete other users articles"
    end

      redirect_to articles_path
  end

private

  def article_params
    params.require(:article).permit(:title, :text)
  end



end
