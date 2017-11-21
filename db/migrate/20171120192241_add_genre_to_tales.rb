class AddGenreToTales < ActiveRecord::Migration[5.1]
  def change
    add_column :tales, :genre_id, :integer
    add_index :tales, :genre_id
  end
end
