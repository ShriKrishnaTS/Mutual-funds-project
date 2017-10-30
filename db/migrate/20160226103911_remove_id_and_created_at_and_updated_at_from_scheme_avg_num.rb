class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeAvgNum < ActiveRecord::Migration
  def change
    remove_column :scheme_avg_nums, :id, :integer
    remove_column :scheme_avg_nums, :created_at, :datetime
    remove_column :scheme_avg_nums, :updated_at, :datetime
  end
end
