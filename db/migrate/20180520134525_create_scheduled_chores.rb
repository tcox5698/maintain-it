class CreateScheduledChores < ActiveRecord::Migration[5.2]
  def change
    create_table :scheduled_chores do |t|
      t.datetime :due
      t.belongs_to :chore, foreign_key: true
      t.belongs_to :site, foreign_key: true

      t.timestamps
    end
  end
end
