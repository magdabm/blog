class CommentsController < ApplicationController
   http_basic_authenticate_with name: "admin", password: "secret", only: :destroy
   before_action :find_article
   before_action :authenticate_user!

   def create
      @comment = Comment.new(comment_params)
      @comment.article = @article
      @comment.user = current_user if current_user
      @like = Like.find_or_initialize_by(article: @article, user: current_user)
      if @comment.save
         flash[:notice] = "Your comment has been added to the article."
         redirect_to article_path(@article)
      else
         render 'articles/show'
      end
   end

   def destroy
      @comment = Comment.find(params[:id])
      return unless authorize_comment
      @comment.destroy
      flash[:notice] = "Your comment has been deleted."
      redirect_to article_path(@article)
   end

   def edit
      @comment = Comment.find(params[:id])
      return unless authorize_comment
   end

   def update
      @comment = Comment.find(params[:id])
      return unless authorize_comment

      if @comment.update(comment_params)
         flash[:notice] = "Your comment has been updated."
         redirect_to article_path(@article)
      else
         render 'edit'
      end
   end


   private

   def authorize_comment
      if @comment.user != current_user && !current_user&.admin?
         flash[:alert] = "You are not allowed to be here."
         redirect_to welcome_index_path
         false
      else
         true
      end
   end

   def find_article
      @article = Article.find(params[:article_id])
   end

   def comment_params
      params.require(:comment).permit(:body, :user)
   end

end
