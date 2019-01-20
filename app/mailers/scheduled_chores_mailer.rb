class ScheduledChoresMailer < ApplicationMailer

  def chores_email
    site = params[:site]
    Rails.logger.info "ScheduledChoresMailer GOT SITE: #{site.inspect}"

    @scheduled_chores = site.scheduled_chores

    Rails.logger.info "ScheduledChoresMailer GOT SCHEDULED CHORES"

    site.site_members.each do |member|
      Rails.logger.info "ScheduledChoresMailer queueing email to: #{member.user.email}"

      mail(to: member.user.email, subject: "MaintainIt! It's time to get some chores done!")
    end
  end
end