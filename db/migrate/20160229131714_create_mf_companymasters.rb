class CreateMfCompanymasters < ActiveRecord::Migration
  def change
    create_table :mf_companymasters do |t|
      t.integer :fincode, index: true, primary_key: true
      t.string :scripcode, limit: 6
      t.string :symbol, limit: 50
      t.string :compname, limit: 225
      t.string :s_name, limit: 150
      t.integer :ind_code
      t.string :ind_name, limit: 50
      t.string :isin, limit: 50
      t.string :status, limit: 50
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
