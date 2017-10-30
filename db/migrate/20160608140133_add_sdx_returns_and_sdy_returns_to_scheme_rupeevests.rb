class AddSdxReturnsAndSdyReturnsToSchemeRupeevests < ActiveRecord::Migration
  def change
    add_column :scheme_rupeevests, :sdx_returns, :decimal
    add_column :scheme_rupeevests, :sdy_returns, :decimal
  end
end
