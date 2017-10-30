class RemoveIdAndCreatedAtAndUpdatedAtFromSectMst < ActiveRecord::Migration
  def change
    remove_column :sect_msts, :id, :integer
    remove_column :sect_msts, :created_at, :datetime
    remove_column :sect_msts, :updated_at, :datetime
  end
end
