namespace :chores do
  desc "TODO"
  task schedule: :environment do
    ScheduleChoresJob.perform_now
  end
end
