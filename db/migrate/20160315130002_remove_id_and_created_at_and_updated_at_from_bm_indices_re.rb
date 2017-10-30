class RemoveIdAndCreatedAtAndUpdatedAtFromBmIndicesRe < ActiveRecord::Migration
  def change
    remove_column :bm_indices_res, :id, :integer
    remove_column :bm_indices_res, :created_at, :datetime
    remove_column :bm_indices_res, :updated_at, :datetime
  end
end
