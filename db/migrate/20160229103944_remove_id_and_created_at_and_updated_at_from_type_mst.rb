class RemoveIdAndCreatedAtAndUpdatedAtFromTypeMst < ActiveRecord::Migration
  def change
    remove_column :type_msts, :id, :integer
    remove_column :type_msts, :created_at, :datetime
    remove_column :type_msts, :updated_at, :datetime
  end
end
