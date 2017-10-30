class CreateAvgSchemeAums < ActiveRecord::Migration
  def change
    create_table :avg_scheme_aums do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :datetime, index: true, primary_key: true
      t.decimal :exfof
      t.decimal :fof
      t.decimal :total
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
