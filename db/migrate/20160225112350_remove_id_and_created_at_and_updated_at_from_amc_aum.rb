class RemoveIdAndCreatedAtAndUpdatedAtFromAmcAum < ActiveRecord::Migration
  def change
    remove_column :amc_aums, :id, :integer
    remove_column :amc_aums, :created_at, :datetime
    remove_column :amc_aums, :updated_at, :datetime
  end
end
