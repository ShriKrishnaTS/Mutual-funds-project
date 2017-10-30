class CreateMfiNews < ActiveRecord::Migration
  def change
    create_table :mfi_news do |t|
      t.integer :news_id, index: true, primary_key: true
      t.string :section_name, limit: 50
      t.string :subsection_name, limit: 50
      t.date :date
      t.string :time, limit: 5
      t.string :headline, limit: 150
      t.string :summary, limit: 250
      t.string :details_news, limit: 1024
      t.string :amccode, limit: 100
      t.string :schemecode, limit: 100
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
