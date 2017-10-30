class CreatePlanMsts < ActiveRecord::Migration
  def change
    create_table :plan_msts do |t|
      t.integer :plan_code, index: true, primary_key: true
      t.string :plan, limit: 50
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
