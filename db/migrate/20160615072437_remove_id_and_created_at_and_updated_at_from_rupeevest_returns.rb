class RemoveIdAndCreatedAtAndUpdatedAtFromRupeevestReturns < ActiveRecord::Migration
  def change
    remove_column :rupeevest_returns, :id, :integer
    remove_column :rupeevest_returns, :created_at, :datetime
    remove_column :rupeevest_returns, :updated_at, :datetime
  end
end
