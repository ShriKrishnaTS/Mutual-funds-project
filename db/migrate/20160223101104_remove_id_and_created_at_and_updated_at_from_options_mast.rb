class RemoveIdAndCreatedAtAndUpdatedAtFromOptionsMast < ActiveRecord::Migration
  def change
    remove_column :options_masts, :id, :integer
    remove_column :options_masts, :created_at, :datetime
    remove_column :options_masts, :updated_at, :datetime
  end
end
