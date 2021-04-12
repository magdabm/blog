class OpinionsController < ApplicationController

  def create
    @article = Article.published.find(params[:article_id])
    @comment = Comment.find(params[:comment_id])
    @opinion = Opinion.new(opinion_params)
    @opinion.user = current_user if current_user
    @opinion.comment = @comment
    @opinion.comment.article = @article
    @opinion.save

    redirect_to article_path(@article)
  end

  def destroy
    @opinion = Opinion.find(params[:id])
    @opinion.destroy
    redirect_to article_path(@opinion.comment.article)
  end

  private
  def opinion_params
     params.require(:opinion).permit(:opinion, :user)
  end

end
