class AddRankSharpeAndSharpexReturnsAndSharpeyReturnsToSchemeRupeevests < ActiveRecord::Migration
  def change
    add_column :scheme_rupeevests, :rank_sharpe, :integer
    add_column :scheme_rupeevests, :sharpex_returns, :decimal
    add_column :scheme_rupeevests, :sharpey_returns, :decimal
  end
end
