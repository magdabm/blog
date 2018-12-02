class Comment < ApplicationRecord
   validates :commenter, presence: true
   validates :body, presence: true, length: { in: 5..500 }

   belongs_to :article
end
