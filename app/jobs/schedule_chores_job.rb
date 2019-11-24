# frozen_string_literal: true

class ScheduleChoresJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Chore.all.each do |chore|
      next if chore.already_scheduled?

      Time.use_zone(chore.site.time_zone) do
        ten_pm_today = Time.zone.now.end_of_day - 2.hours
        due = ten_pm_today
        due = (due + 1.day) if Time.zone.now > ten_pm_today

        ScheduledChore.create!(chore: chore, site: chore.site, due: due)
      end
    end
  end
end
