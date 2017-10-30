class RemoveIdAndCreatedAtAndUpdatedAtFromAvgMaturity < ActiveRecord::Migration
  def change
    remove_column :avg_maturities, :id, :integer
    remove_column :avg_maturities, :created_at, :datetime
    remove_column :avg_maturities, :updated_at, :datetime
  end
end
