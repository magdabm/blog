class AddCoverToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :cover, :string
  end
end
