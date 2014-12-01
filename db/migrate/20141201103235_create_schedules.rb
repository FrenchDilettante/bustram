class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :trip_id
      t.integer :stop_id
      t.integer :location_id
      t.integer :departure_time
      t.integer :stop_sequence
    end
  end
end
