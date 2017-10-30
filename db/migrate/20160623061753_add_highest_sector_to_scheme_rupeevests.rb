class AddHighestSectorToSchemeRupeevests < ActiveRecord::Migration
  def change
    add_column :scheme_rupeevests, :highest_sector, :string
  end
end
