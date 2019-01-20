namespace :chores do
  desc "Notify members of scheduled chores"
  task notify: :environment do
    NotifyScheduledChoresJob.perform_now
  end

  desc "Schedule chores for all sites"
  task schedule: :environment do
    ScheduleChoresJob.perform_now
  end
end
