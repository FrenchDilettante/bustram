class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :route_id
      t.integer :timeframe_id
      t.string :code
      t.string :headsign
      t.integer :direction_id
    end
  end
end
