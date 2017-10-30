class AddHoldPercQ1AndHoldPercQ2AndHoldPercQ3AndHoldPercQ4AndHoldPercQ5ToRupeevestSectHoldpercs < ActiveRecord::Migration
  def change
    add_column :rupeevest_sect_holdpercs, :hold_perc_q1, :decimal
    add_column :rupeevest_sect_holdpercs, :hold_perc_q2, :decimal
    add_column :rupeevest_sect_holdpercs, :hold_perc_q3, :decimal
    add_column :rupeevest_sect_holdpercs, :hold_perc_q4, :decimal
    add_column :rupeevest_sect_holdpercs, :hold_perc_q5, :decimal
  end
end
