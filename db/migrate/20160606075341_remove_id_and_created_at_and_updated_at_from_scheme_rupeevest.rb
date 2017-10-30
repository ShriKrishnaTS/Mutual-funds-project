class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeRupeevest < ActiveRecord::Migration
  def change
    remove_column :scheme_rupeevests, :id, :integer
    remove_column :scheme_rupeevests, :created_at, :datetime
    remove_column :scheme_rupeevests, :updated_at, :datetime
  end
end
