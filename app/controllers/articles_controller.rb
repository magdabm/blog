class ArticlesController < ApplicationController

   http_basic_authenticate_with name: "admin", password: "secret",
      except: [:index, :show]
   before_action :find_article, only: [:show, :edit, :update, :destroy] # zamiast wywoływać metodę find_article tam gdzie jest potrzebna można dodać before action

   def index
      @articles = Article.all.order(id: :desc)
      @articles = @articles.where("? = any(tags)", params[:q]) if params[:q].present?
      # lub @articles = @articles.select { |a| a.tags.include? params[:q] } if params[:q].present?
   end

   def new
      @article = Article.new
   end

   def create
      @article = Article.new(article_params)
      @article.user = current_user if current_user
      if @article.save
         redirect_to article_path(@article)
         flash[:notice] = "Your article has beed succesfully saved in our data base."
      else
         render 'new'
      end
   end

   def show
      @comment = Comment.new(commenter: session[:commenter])
   end

   def edit
      return unless authorize_article
   end

   def update
      return unless authorize_article
      if @article.update(article_params)
         flash[:notice] = "Your article has been succesfully updated in our data base."
         redirect_to article_path(@article)
      else
         render 'edit'
      end
   end

   def destroy
      return unless authorize_article
      @article.destroy
      flash[:notice] = "Your article has been succesfully deleted from our data base."
      redirect_to welcome_index_path
   end

   private

   def authorize_article
      if @article.user != current_user && !current_user&.admin?
         flash[:alert] = "You are not allowed to be here"
         redirect_to welcome_index_path
         false
      else
         true
      end
   end

   def article_params
      params.require(:article).permit(:title, :text, :tags, :user)
   end

   def find_article
      @article = Article.find(params[:id])
   end
end
