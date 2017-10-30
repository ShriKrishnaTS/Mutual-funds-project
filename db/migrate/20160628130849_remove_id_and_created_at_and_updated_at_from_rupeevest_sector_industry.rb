class RemoveIdAndCreatedAtAndUpdatedAtFromRupeevestSectorIndustry < ActiveRecord::Migration
  def change
    remove_column :rupeevest_sector_industries, :id, :integer
    remove_column :rupeevest_sector_industries, :created_at, :datetime
    remove_column :rupeevest_sector_industries, :updated_at, :datetime
  end
end
