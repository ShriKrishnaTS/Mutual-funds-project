class RemoveIdAndCreatedAtAndUpdatedAtFromDivMst < ActiveRecord::Migration
  def change
    remove_column :div_msts, :id, :integer
    remove_column :div_msts, :created_at, :datetime
    remove_column :div_msts, :updated_at, :datetime
  end
end
