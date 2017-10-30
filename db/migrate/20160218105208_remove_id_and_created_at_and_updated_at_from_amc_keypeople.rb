class RemoveIdAndCreatedAtAndUpdatedAtFromAmcKeypeople < ActiveRecord::Migration
  def change
    remove_column :amc_keypeople, :id, :integer
    remove_column :amc_keypeople, :created_at, :datetime
    remove_column :amc_keypeople, :updated_at, :datetime
  end
end
