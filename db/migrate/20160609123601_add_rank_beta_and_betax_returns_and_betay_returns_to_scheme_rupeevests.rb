class AddRankBetaAndBetaxReturnsAndBetayReturnsToSchemeRupeevests < ActiveRecord::Migration
  def change
    add_column :scheme_rupeevests, :rank_beta, :integer
    add_column :scheme_rupeevests, :betax_returns, :decimal
    add_column :scheme_rupeevests, :betay_returns, :decimal
  end
end
