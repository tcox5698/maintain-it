class NotifyScheduledChoresJob < ApplicationJob
  queue_as :default

  def perform(*args)
    scheduled_sites = ScheduledChore.pluck(:site_id)
    Site.where(id: scheduled_sites).each do |site|
      scheduled_chores = site.scheduled_chores
      site.site_members.each do |site_member|
        ScheduledChoresMailer.chores_email(site_member: site_member, scheduled_chores: scheduled_chores).deliver_later
      end
    end
  end
end
