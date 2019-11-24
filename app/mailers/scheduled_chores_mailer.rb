# frozen_string_literal: true

class ScheduledChoresMailer < ApplicationMailer
  def chores_email
    site = params[:site]
    Rails.logger.info "ScheduledChoresMailer GOT SITE: #{site.inspect}"
    @scheduled_chores = site.scheduled_chores

    Rails.logger.info 'ScheduledChoresMailer GOT SCHEDULED CHORES'
    enabled_members = site.site_members.select { |m| m.notification_channel_enabled?('email') }

    mail(
      bcc: enabled_members.map { |m| m.user.email },
      subject: "MaintainIt! It's time to get some chores done!"
    )
  end
end
