# frozen_string_literal: true

require 'net/http'

class NotifyScheduledChoresJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    scheduled_sites = ScheduledChore.pluck(:site_id)
    Rails.logger.info("found site ids to notify: #{scheduled_sites}")

    schedule_chores_mailers(scheduled_sites)
    trigger_worker
  end

  def schedule_chores_mailers(scheduled_sites)
    Site.where(id: scheduled_sites).each do |site|
      Rails.logger.info("Queueing ScheduledChoresMailer with site: #{site}")
      ScheduledChoresMailer.with(site: site).chores_email.deliver_later(queue: :default)
    end
  end

  def trigger_worker
    app_url = ENV['APP_ROOT_URL']&.strip

    if app_url
      Rails.logger.info("Pinging app url to trigger worker: #{app_url}")
      Net::HTTP.get(URI.parse(app_url))
    else
      msg = 'NO APP_ROOT_URL set - no ping. worker probably will not run your mail jobs.'
      Rails.logger.info(msg)
    end
  end
end
