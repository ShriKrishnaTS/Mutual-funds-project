class AddRankSotinoAndSotinoxReturnsAndSotinoyReturnsToSchemeRupeevests < ActiveRecord::Migration
  def change
    add_column :scheme_rupeevests, :rank_sotino, :integer
    add_column :scheme_rupeevests, :sotinox_returns, :decimal
    add_column :scheme_rupeevests, :sotinoy_returns, :decimal
  end
end
