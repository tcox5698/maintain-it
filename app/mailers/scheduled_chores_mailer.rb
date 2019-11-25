# frozen_string_literal: true

class ScheduledChoresMailer < ApplicationMailer
  before_action :set_site
  before_action :fetch_scheduled_chores

  def chores_email
    mail(
      bcc: email_addresses(@site),
      subject: "MaintainIt! It's time to get some chores done!"
    )
  end

  def set_site
    @site = params[:site]
  end

  def fetch_scheduled_chores
    @scheduled_chores = @site.scheduled_chores
  end

  def email_addresses(site)
    enabled_members(site).map { |m| m.user.email }
  end

  def enabled_members(site)
    site.site_members.select { |m| m.notification_channel_enabled?('email') }
  end
end
