class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
