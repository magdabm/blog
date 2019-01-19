class ArticlesController < ApplicationController

   http_basic_authenticate_with name: "admin", password: "secret", except: [:index, :show]
   before_action :find_article, only: [:show, :edit, :update, :destroy]
   before_action :authenticate_user!, except: [:show, :index]
   before_action :authorize_article, only: [:edit, :update, :destroy]

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
         flash[:notice] = "Your article has beed succesfully saved in our data base."
         redirect_to article_path(@article)
      else
         render 'new'
      end
   end

   def show
      @comment = Comment.new
      @like = Like.find_or_initialize_by(article: @article, user: current_user)


      respond_to do |format|
        format.html do
          @article.increment!(:views_count)
          render
        end
        format.json do
          render json: {
            id: @article.id,
            title: @article.title,
            text: @article.text,
            views_count: @article.views_count,
            likes_count: @article.likes.count,
            comments_count: @article.comments.count
          }
        end
      end
   end

   def edit
   end

   def update
      if @article.update(article_params)
         flash[:notice] = "Your article has been succesfully updated in our data base."
         redirect_to article_path(@article)
      else
         render 'edit'
      end
   end

   def destroy
      @article.destroy
      flash[:notice] = "Your article has been succesfully deleted from our data base."
      redirect_to welcome_index_path
   end

   private

   def authorize_article
      if @article.user != current_user && !current_user&.admin?
         flash[:alert] = "You are not allowed to be here."
         redirect_to welcome_index_path
         false
      else
         true
      end
   end

   def article_params
      params.require(:article).permit(:title, :text, :tags, :user, :type)
   end

   def find_article
      @article = Article.find(params[:id])
   end
end
