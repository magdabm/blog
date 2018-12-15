class AddConstraintsToComments < ActiveRecord::Migration[5.2]
  def change
     change_column_null :comments, :body, false
     change_column_null :comments, :commenter, false
  end
end
