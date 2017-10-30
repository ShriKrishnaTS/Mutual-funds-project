class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeAssetalloc < ActiveRecord::Migration
  def change
    remove_column :scheme_assetallocs, :id, :integer
    remove_column :scheme_assetallocs, :created_at, :datetime
    remove_column :scheme_assetallocs, :updated_at, :datetime
  end
end
