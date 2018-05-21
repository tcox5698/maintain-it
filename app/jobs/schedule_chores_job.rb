class ScheduleChoresJob < ApplicationJob
  queue_as :default

  def perform(*args)
    chores = Chore.all

    chores.each do |chore|
      Time.use_zone(chore.site.time_zone) do
        ten_pm_today = Time.zone.now.end_of_day - 2.hours

        ScheduledChore.create!(chore: chore, site: chore.site, due: ten_pm_today)
      end
    end
  end
end
