class AddSleepToClockIns < ActiveRecord::Migration[7.0]
  def change
    add_column :clock_ins, :sleep, :boolean, default: true
  end
end
