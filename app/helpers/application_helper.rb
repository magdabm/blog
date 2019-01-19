module ApplicationHelper

  def sponsored_article?(article)
    article.type == 'SponsoredArticle'
  end
end
