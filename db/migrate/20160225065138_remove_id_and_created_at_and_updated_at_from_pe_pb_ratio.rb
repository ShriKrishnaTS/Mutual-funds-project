class RemoveIdAndCreatedAtAndUpdatedAtFromPePbRatio < ActiveRecord::Migration
  def change
    remove_column :pe_pb_ratios, :id, :integer
    remove_column :pe_pb_ratios, :created_at, :datetime
    remove_column :pe_pb_ratios, :updated_at, :datetime
  end
end
