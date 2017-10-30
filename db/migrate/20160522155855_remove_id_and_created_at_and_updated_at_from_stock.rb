class RemoveIdAndCreatedAtAndUpdatedAtFromStock < ActiveRecord::Migration
  def change
    remove_column :stocks, :id, :integer
    remove_column :stocks, :created_at, :datetime
    remove_column :stocks, :updated_at, :datetime
  end
end
