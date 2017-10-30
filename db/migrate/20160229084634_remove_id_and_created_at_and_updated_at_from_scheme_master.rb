class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeMaster < ActiveRecord::Migration
  def change
    remove_column :scheme_masters, :id, :integer
    remove_column :scheme_masters, :created_at, :datetime
    remove_column :scheme_masters, :updated_at, :datetime
  end
end
