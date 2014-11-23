class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :short_name
      t.string :long_name
      t.string :code

      t.timestamps
    end
  end
end
