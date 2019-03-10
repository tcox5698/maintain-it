class CreateScheduledChoreStatusType < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
          CREATE TYPE scheduled_chore_status AS ENUM (
            'scheduled', 'completed'
          );
    DDL
  end

  def down
    execute <<-DDL
          DROP TYPE scheduled_chore_status;
    DDL
  end
end
