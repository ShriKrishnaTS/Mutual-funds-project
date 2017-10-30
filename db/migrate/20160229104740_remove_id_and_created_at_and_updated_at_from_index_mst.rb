class RemoveIdAndCreatedAtAndUpdatedAtFromIndexMst < ActiveRecord::Migration
  def change
    remove_column :index_msts, :id, :integer
    remove_column :index_msts, :created_at, :datetime
    remove_column :index_msts, :updated_at, :datetime
  end
end
