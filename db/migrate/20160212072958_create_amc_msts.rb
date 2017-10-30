class CreateAmcMsts < ActiveRecord::Migration
  def change
    create_table :amc_msts do |t|

      t.timestamps null: false
    end
  end
end
