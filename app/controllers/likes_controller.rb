class LikesController < ApplicationController

  def create
    like = Like.new(article_id: params[:article_id], user: current_user)
    like.save
    UserMailer.liked_article(like.article.user).deliver
    redirect_to article_path(like.article)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to article_path(like.article)
  end

end
