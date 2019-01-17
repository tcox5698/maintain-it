class NotifyScheduledChoresJob < ApplicationJob
  queue_as :default

  def perform(*args)
    scheduled_sites = ScheduledChore.pluck(:site_id)

    Rails.logger.info("found site ids to notify: #{scheduled_sites}")

    Site.where(id: scheduled_sites).each do |site|
      Rails.logger.info("Queueing ScheduledChoresMailer with site: #{site}")


      ScheduledChoresMailer.with(site: site).chores_email.deliver_later

    end
  end
end
