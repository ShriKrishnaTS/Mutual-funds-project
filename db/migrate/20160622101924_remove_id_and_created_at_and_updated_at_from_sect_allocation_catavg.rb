class RemoveIdAndCreatedAtAndUpdatedAtFromSectAllocationCatavg < ActiveRecord::Migration
  def change
    remove_column :sect_allocation_catavgs, :id, :integer
    remove_column :sect_allocation_catavgs, :created_at, :datetime
    remove_column :sect_allocation_catavgs, :updated_at, :datetime
  end
end
