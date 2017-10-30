class RemoveIdAndCreatedAtAndUpdatedAtFromAvgAmcAum < ActiveRecord::Migration
  def change
    remove_column :avg_amc_aums, :id, :integer
    remove_column :avg_amc_aums, :created_at, :datetime
    remove_column :avg_amc_aums, :updated_at, :datetime
  end
end
