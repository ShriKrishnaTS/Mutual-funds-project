class CreateSchemeAssetallocs < ActiveRecord::Migration
  def change
    create_table :scheme_assetallocs do |t|
      t.integer :schemeinv_id
      t.integer :schemecode, index: true, primary_key: true
      t.string :investment, index: true, primary_key: true, limit: 700
      t.decimal :mininv
      t.decimal :maxniv
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
