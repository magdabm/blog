class CommentsController < ApplicationController
   http_basic_authenticate_with name: "admin", password: "secret", only: :destroy
   before_action :find_article

   def create
      @comment = Comment.new(comment_params)
      @comment.article = @article
      if @comment.save
         redirect_to article_path(@article)
         session[:commenter] = @comment.commenter
      else
         render 'articles/show'
      end
   end

   def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article)
   end

   def edit
      @comment = Comment.find(params[:id])
   end

   def update
      @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
         redirect_to article_path(@article)
      else
         render 'edit'
      end
   end


   private

   def find_article
      @article = Article.find(params[:article_id])
   end

   def comment_params
      params.require(:comment).permit(:commenter, :body)
   end

end
