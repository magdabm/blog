class CommentsController < ApplicationController
   before_action :find_article

   def create
      @comment = Comment.new(comment_params)
      @comment.article = @article
      if @comment.save
         redirect_to article_path(@article)
      else
         render 'articles/show'
      end
   end

   def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article)
   end


   private

   def find_article
      @article = Article.find(params[:article_id])
   end

   def comment_params
      params.require(:comment).permit(:commenter, :body)
   end

end
