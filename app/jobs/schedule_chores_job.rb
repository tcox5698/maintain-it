class ScheduleChoresJob < ApplicationJob
  queue_as :default

  def perform(*args)
    chores = Chore.find_by_sql("SELECT * FROM chores
      WHERE chores.id NOT IN (select chore_id from scheduled_chores)")

    chores.each do |chore|
      Time.use_zone(chore.site.time_zone) do
        ten_pm_today = Time.zone.now.end_of_day - 2.hours

        ScheduledChore.create!(chore: chore, site: chore.site, due: ten_pm_today)
      end
    end
  end
end
