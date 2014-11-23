class CreateTimeframes < ActiveRecord::Migration
  def change
    create_table :timeframes do |t|
      t.string :code
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.date :start_date
      t.date :end_date
    end
  end
end
