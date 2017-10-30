class RemoveIdAndCreatedAtAndUpdatedAtFromAmcPaum < ActiveRecord::Migration
  def change
    remove_column :amc_paums, :id, :integer
    remove_column :amc_paums, :created_at, :datetime
    remove_column :amc_paums, :updated_at, :datetime
  end
end
