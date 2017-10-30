class CreateSchemeMasters < ActiveRecord::Migration
  def change
    create_table :scheme_masters do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.integer :amc_code
      t.string :scheme_name, limit: 225
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
