class RemoveIdAndCreatedAtAndUpdatedAtFromCustMst < ActiveRecord::Migration
  def change
    remove_column :cust_msts, :id, :integer
    remove_column :cust_msts, :created_at, :datetime
    remove_column :cust_msts, :updated_at, :datetime
  end
end
