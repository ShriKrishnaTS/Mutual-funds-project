class RemoveIdAndCreatedAtAndUpdatedAtFromRupeevestSectorCatAvg < ActiveRecord::Migration
  def change
    remove_column :rupeevest_sector_cat_avgs, :id, :integer
    remove_column :rupeevest_sector_cat_avgs, :created_at, :datetime
    remove_column :rupeevest_sector_cat_avgs, :updated_at, :datetime
  end
end
