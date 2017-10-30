class RemoveIdAndCreatedAtAndUpdatedAtFromRupeevestSector < ActiveRecord::Migration
  def change
    remove_column :rupeevest_sectors, :id, :integer
    remove_column :rupeevest_sectors, :created_at, :datetime
    remove_column :rupeevest_sectors, :updated_at, :datetime
  end
end
