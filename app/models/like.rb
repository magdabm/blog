class Like < ApplicationRecord

  belongs_to :user
  belongs_to :article, counter_cache: true

  validates :user, uniqueness: {scope: :article, message: 'already liked' }

end
