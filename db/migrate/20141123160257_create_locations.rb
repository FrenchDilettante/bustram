class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :code
      t.integer :lat
      t.integer :lon

      t.integer :stop_id

      t.timestamps
    end

    remove_column :stops, :code
  end
end
