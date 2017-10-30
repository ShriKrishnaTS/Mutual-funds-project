class RemoveIdAndCreatedAtAndUpdatedAtFromSclassMst < ActiveRecord::Migration
  def change
    remove_column :sclass_msts, :id, :integer
    remove_column :sclass_msts, :created_at, :datetime
    remove_column :sclass_msts, :updated_at, :datetime
  end
end
