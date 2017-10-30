class RemoveIdAndCreatedAtAndUpdatedAtFromRupeevestSectHoldperc < ActiveRecord::Migration
  def change
    remove_column :rupeevest_sect_holdpercs, :id, :integer
    remove_column :rupeevest_sect_holdpercs, :created_at, :datetime
    remove_column :rupeevest_sect_holdpercs, :updated_at, :datetime
  end
end
