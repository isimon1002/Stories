class AddRankToTales < ActiveRecord::Migration[5.1]
  def change
    add_column :tales, :rank, :float
  end
end
