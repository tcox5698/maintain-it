class AddSysAdminToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sys_admin, :boolean, default: false
  end
end
