class Like < ApplicationRecord

  belongs_to :user
  belongs_to :article

  validates: user, uniqueness: {scope: :article, message: 'already liked' }

end
