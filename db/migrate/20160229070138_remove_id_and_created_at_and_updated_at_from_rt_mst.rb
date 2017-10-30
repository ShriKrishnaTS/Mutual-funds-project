class RemoveIdAndCreatedAtAndUpdatedAtFromRtMst < ActiveRecord::Migration
  def change
    remove_column :rt_msts, :id, :integer
    remove_column :rt_msts, :created_at, :datetime
    remove_column :rt_msts, :updated_at, :datetime
  end
end
