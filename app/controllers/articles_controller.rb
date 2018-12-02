class ArticlesController < ApplicationController

   before_action :find_article, only: [:show, :edit, :update, :destroy] # zamiast wywoływać metodę find_article tam gdzie jest potrzebna można dodać before action

   def index
      @articles = Article.all.order(id: :desc)
   end

   def new
      @article = Article.new
   end

   def create
      article_params
      @article = Article.new(article_params)
      if @article.save
         redirect_to article_path(@article)
      else
         render 'new'
      end
   end

   def show
   end

   def edit
   end

   def update
      article_params
      if @article.update(article_params)
         redirect_to article_path(@article)
      else
         render 'edit'
      end
   end

   def destroy
      @article.destroy
      redirect_to articles_path
   end

   private
   def article_params
      article_params = params.require(:article).permit(:title, :text)
   end

   def find_article
      @article = Article.find(params[:id])
   end
end
