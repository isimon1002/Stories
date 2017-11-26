class AddCountToTales < ActiveRecord::Migration[5.1]
  def change
    add_column :tales, :count, :integer
  end
end
