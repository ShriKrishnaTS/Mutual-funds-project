class RemoveIdAndCreatedAtAndUpdatedAtFromPlanMst < ActiveRecord::Migration
  def change
    remove_column :plan_msts, :id, :integer
    remove_column :plan_msts, :created_at, :datetime
    remove_column :plan_msts, :updated_at, :datetime
  end
end
