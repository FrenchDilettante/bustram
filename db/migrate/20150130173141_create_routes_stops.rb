class CreateRoutesStops < ActiveRecord::Migration
  def change
    create_table :routes_stops, id: false do |t|
      t.integer :stop_id
      t.integer :route_id
    end

    add_index :routes_stops, [:stop_id, :route_id], unique: true
  end
end
