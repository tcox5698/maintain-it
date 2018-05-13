class AddTimeZoneToSite < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :time_zone, :string, default: 'America/Chicago'
  end
end
