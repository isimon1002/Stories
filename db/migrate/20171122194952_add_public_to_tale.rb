class AddPublicToTale < ActiveRecord::Migration[5.1]
  def change
    add_column :tales, :isPublic, :boolean, default: false
    add_index :tales, :isPublic
  end
end
