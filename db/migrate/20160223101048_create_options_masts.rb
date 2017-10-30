class CreateOptionsMasts < ActiveRecord::Migration
  def change
    create_table :options_masts do |t|
      t.integer :opt_code, index: true, primary_key: true
      t.string :option, limit: 50
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
