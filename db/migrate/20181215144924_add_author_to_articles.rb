class AddAuthorToArticles < ActiveRecord::Migration[5.2]
  def change
     add_reference :articles, :user
  end
end
