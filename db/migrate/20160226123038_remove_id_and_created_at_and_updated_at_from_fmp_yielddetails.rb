class RemoveIdAndCreatedAtAndUpdatedAtFromFmpYielddetails < ActiveRecord::Migration
  def change
    remove_column :fmp_yielddetails, :id, :integer
    remove_column :fmp_yielddetails, :created_at, :datetime
    remove_column :fmp_yielddetails, :updated_at, :datetime
  end
end
