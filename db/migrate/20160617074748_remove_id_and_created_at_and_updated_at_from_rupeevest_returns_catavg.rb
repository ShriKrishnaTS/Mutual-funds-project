class RemoveIdAndCreatedAtAndUpdatedAtFromRupeevestReturnsCatavg < ActiveRecord::Migration
  def change
    remove_column :rupeevest_returns_catavgs, :id, :integer
    remove_column :rupeevest_returns_catavgs, :created_at, :datetime
    remove_column :rupeevest_returns_catavgs, :updated_at, :datetime
  end
end
