class RemoveIdAndCreatedAtAndUpdatedAtFromSectAllocation < ActiveRecord::Migration
  def change
    remove_column :sect_allocations, :id, :integer
    remove_column :sect_allocations, :created_at, :datetime
    remove_column :sect_allocations, :updated_at, :datetime
  end
end
