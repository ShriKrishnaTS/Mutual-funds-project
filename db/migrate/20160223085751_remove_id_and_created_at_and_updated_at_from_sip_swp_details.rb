class RemoveIdAndCreatedAtAndUpdatedAtFromSipSwpDetails < ActiveRecord::Migration
  def change
    remove_column :sip_swp_details, :id, :integer
    remove_column :sip_swp_details, :created_at, :datetime
    remove_column :sip_swp_details, :updated_at, :datetime
  end
end
