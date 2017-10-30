class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.string :fund, limit: 255
      t.decimal :dec_15
      t.decimal :sep_15
      t.decimal :jun_15
      t.decimal :mar_15
      t.decimal :sep_15
      t.decimal :dec_15

      t.timestamps null: false
    end
  end
end
