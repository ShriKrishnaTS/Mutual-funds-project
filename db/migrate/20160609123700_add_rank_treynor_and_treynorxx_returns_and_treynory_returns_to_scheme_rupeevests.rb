class AddRankTreynorAndTreynorxxReturnsAndTreynoryReturnsToSchemeRupeevests < ActiveRecord::Migration
  def change
    add_column :scheme_rupeevests, :rank_treynor, :integer
    add_column :scheme_rupeevests, :treynorx_returns, :decimal
    add_column :scheme_rupeevests, :treynory_returns, :decimal
  end
end
