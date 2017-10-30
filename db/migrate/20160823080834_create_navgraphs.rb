class CreateNavgraphs < ActiveRecord::Migration
  def change
    create_table :navgraphs do |t|
      t.integer :schemecode
      t.datetime :navdate
      t.decimal :month6_yvalue
      t.decimal :year1_yvalue
      t.decimal :year3_yvalue
      t.decimal :year5_yvalue

      t.timestamps null: false
    end
  end
end
