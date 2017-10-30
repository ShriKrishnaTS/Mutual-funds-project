class RemoveIdAndCreatedAtAndUpdatedAtFromNavhistfull < ActiveRecord::Migration
  def change
    remove_column :navhistfulls, :id, :integer
    remove_column :navhistfulls, :created_at, :datetime
    remove_column :navhistfulls, :updated_at, :datetime
  end
end
