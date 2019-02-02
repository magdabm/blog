class Comment < ApplicationRecord

 validates :body, presence: true, length: { in: 5..500 }

 belongs_to :article, counter_cache: true
 belongs_to :user
 has_many :opinions


 def rating_sum
   array = opinions.map do |o|
     o.opinion
   end
   array.sum
 end

end
