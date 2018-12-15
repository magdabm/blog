class AddTagsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :tags, :text, array: true, default: []
  end
end
