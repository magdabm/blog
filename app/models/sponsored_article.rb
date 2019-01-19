class SponsoredArticle < Article

  belongs_to :company

  def css_class
    'sponsored'
  end

end
