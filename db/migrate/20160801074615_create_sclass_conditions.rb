class CreateSclassConditions < ActiveRecord::Migration
  def change
    create_table :sclass_conditions do |t|
      t.integer :cnno
      t.string :condition_st

      t.timestamps null: false
    end
  end
end
