class AddRoutesTransportType < ActiveRecord::Migration
  def change
    add_column :routes, :transport_type, :string
  end
end
