class AddStopsSlug < ActiveRecord::Migration
  def change
    add_column :stops, :slug, :string
  end
end
