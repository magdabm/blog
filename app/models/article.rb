class Article < ApplicationRecord

   validates :title, presence: true, length: { minimum: 5 }

   has_many :comments, dependent: :destroy
   belongs_to :user
   has_many :likes
   has_many :users, through: :likes

   def tags=(value)
      value = sanitize_tags(value) if value.is_a?(String)
      super(value)
   end

   private

   def sanitize_tags(text)
      text.downcase.split.uniq
   end

end
