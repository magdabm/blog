class AddCounterCasheToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :likes_count, :integer, default: 0
    add_column :articles, :comments_count, :integer, default: 0
  end
end
