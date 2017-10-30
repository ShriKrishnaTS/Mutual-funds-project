class AddRankSdToSchemeRupeevests < ActiveRecord::Migration
  def change
    add_column :scheme_rupeevests, :rank_sd, :integer
  end
end
