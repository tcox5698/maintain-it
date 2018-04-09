class AddRoleToSiteMember < ActiveRecord::Migration[5.1]
  def change
    add_column :site_members, :role, :string, null: false, default: 'visitor'
  end
end
