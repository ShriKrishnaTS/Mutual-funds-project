class CreateAmcPaums < ActiveRecord::Migration
  def change
    create_table :amc_paums do |t|
      t.integer :amc_code, index: true, primary_key: true
      t.datetime :aumdate
      t.decimal :totalaum
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
