class AddTypeAndCompanyToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :type, :string
    add_reference :articles, :company, foreign_key: false, null: true
  end
end
