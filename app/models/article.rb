class Article < ApplicationRecord

   validates :title, presence: true, length: { minimum: 5 }

   has_many :comments, dependent: :destroy

   def tags=(value)
      value = sanitize_tags(value) if value.is_a?(String)
      super(value)
   end

   private

   def sanitize_tags(text)
      text.downcase.split.uniq
   end

end
