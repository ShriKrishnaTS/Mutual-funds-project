class RemoveIdAndCreatedAtAndUpdatedAtFromSector < ActiveRecord::Migration
  def change
    remove_column :sectors, :id, :integer
    remove_column :sectors, :created_at, :datetime
    remove_column :sectors, :updated_at, :datetime
  end
end
