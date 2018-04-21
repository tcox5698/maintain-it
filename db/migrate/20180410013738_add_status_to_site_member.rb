class AddStatusToSiteMember < ActiveRecord::Migration[5.1]
  def change
    add_column :site_members, :status, :string, null: false, default: 'absent'
  end
end
