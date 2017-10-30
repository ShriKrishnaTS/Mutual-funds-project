class CreateClassificationMasters < ActiveRecord::Migration
  def change
    create_table :classification_masters do |t|
      t.integer :classification_id, index: true, primary_key: true
      t.string :classification, limit: 255

      t.timestamps null: false
    end
  end
end
