class AddUserToTales < ActiveRecord::Migration[5.1]
  def change
    add_column :tales, :user_id, :integer
    add_index :tales, :user_id
  end
end
