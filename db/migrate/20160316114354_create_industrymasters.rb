class CreateIndustrymasters < ActiveRecord::Migration
  def change
    create_table :industrymasters do |t|
      t.integer :ind_code, index: true, primary_key: true
      t.string :industry, limit: 100
      t.string :ind_shortname, limit: 100
      t.string :sector, limit: 100
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
