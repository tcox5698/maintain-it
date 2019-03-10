class AddStatusToScheduledChore < ActiveRecord::Migration[5.2]
  def change
    add_column :scheduled_chores, :status, :scheduled_chore_status, default: 'scheduled'
  end
end
