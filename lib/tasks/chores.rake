namespace :chores do
  desc "Notify members of scheduled chores"
  task notify: :environment do
    NotifyScheduledChoresJob.perform_now

    Rails.logger.info "Sleeping to allow email sends"
    sleep 15
    Rails.logger.info "Waking to exit rake task"
  end


  desc "Schedule chores for all sites"
  task schedule: :environment do
    ScheduleChoresJob.perform_now
  end
end
