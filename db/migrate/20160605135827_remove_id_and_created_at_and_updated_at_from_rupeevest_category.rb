class RemoveIdAndCreatedAtAndUpdatedAtFromRupeevestCategory < ActiveRecord::Migration
  def change
    remove_column :rupeevest_categories, :id, :integer
    remove_column :rupeevest_categories, :created_at, :datetime
    remove_column :rupeevest_categories, :updated_at, :datetime
  end
end
