class AddRoutesSubRoute < ActiveRecord::Migration
  def change
    add_column :routes, :sub_route, :boolean, default: false
  end
end
