class RemoveIdAndCreatedAtAndUpdatedAtFromSclassCondition < ActiveRecord::Migration
  def change
    remove_column :sclass_conditions, :id, :integer
    remove_column :sclass_conditions, :created_at, :datetime
    remove_column :sclass_conditions, :updated_at, :datetime
  end
end
