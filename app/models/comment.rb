class Comment < ApplicationRecord

   include ActiveModel::Validations

   validates :body, presence: true, length: { in: 5..500 }

   belongs_to :article, counter_cache: true
   belongs_to :user
end
