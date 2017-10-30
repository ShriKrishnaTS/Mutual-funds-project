class RemoveIdAndCreatedAtAndUpdatedAtFromAmcMsts < ActiveRecord::Migration
  def change
    remove_column :amc_msts, :id, :integer
    remove_column :amc_msts, :created_at, :datetime
    remove_column :amc_msts, :updated_at, :datetime
  end
end
