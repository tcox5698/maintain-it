class NotifyScheduledChoresJob < ApplicationJob
  queue_as :default

  def perform(*args)
    scheduled_sites = ScheduledChore.pluck(:site_id)
    Site.where(id: scheduled_sites).each do |site|
        ScheduledChoresMailer.with(site: site).chores_email.deliver_later

    end
  end
end
