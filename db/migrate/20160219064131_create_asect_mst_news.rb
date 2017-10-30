class CreateAsectMstNews < ActiveRecord::Migration
  def change
    create_table :asect_mst_news do |t|
      t.decimal :asect_code, index: true, primary_key: true
      t.string :asect_type, limit: 100
      t.string :asset, limit: 25
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
