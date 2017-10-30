class RemoveIdAndCreatedAtAndUpdatedAtFromDivdetails < ActiveRecord::Migration
  def change
    remove_column :divdetails, :id, :integer
    remove_column :divdetails, :created_at, :datetime
    remove_column :divdetails, :updated_at, :datetime
  end
end
