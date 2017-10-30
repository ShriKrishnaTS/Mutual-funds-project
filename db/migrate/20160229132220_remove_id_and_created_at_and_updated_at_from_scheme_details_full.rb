class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeDetailsFull < ActiveRecord::Migration
  def change
    remove_column :scheme_details_fulls, :id, :integer
    remove_column :scheme_details_fulls, :created_at, :datetime
    remove_column :scheme_details_fulls, :updated_at, :datetime
  end
end
