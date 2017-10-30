class RemoveIdAndCreatedAtAndUpdatedAtFromFvchange < ActiveRecord::Migration
  def change
    remove_column :fvchanges, :id, :integer
    remove_column :fvchanges, :created_at, :datetime
    remove_column :fvchanges, :updated_at, :datetime
  end
end
