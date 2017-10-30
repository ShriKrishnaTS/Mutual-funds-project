class AddRankAlphaAndAlphaxReturnsAndAlphayReturnsToSchemeRupeevests < ActiveRecord::Migration
  def change
    add_column :scheme_rupeevests, :rank_alpha, :integer
    add_column :scheme_rupeevests, :alphax_returns, :decimal
    add_column :scheme_rupeevests, :alphay_returns, :decimal
  end
end
