class RemoveIdAndCreatedAtAndUpdatedAtFromThemeMst < ActiveRecord::Migration
  def change
    remove_column :theme_msts, :id, :integer
    remove_column :theme_msts, :created_at, :datetime
    remove_column :theme_msts, :updated_at, :datetime
  end
end
