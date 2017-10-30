class RemoveIdAndCreatedAtAndUpdatedAtFromLoadtypeMst < ActiveRecord::Migration
  def change
    remove_column :loadtype_msts, :id, :integer
    remove_column :loadtype_msts, :created_at, :datetime
    remove_column :loadtype_msts, :updated_at, :datetime
  end
end
