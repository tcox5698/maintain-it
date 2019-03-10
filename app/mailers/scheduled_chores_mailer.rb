class ScheduledChoresMailer < ApplicationMailer

  def chores_email
    site = params[:site]
    Rails.logger.info "ScheduledChoresMailer GOT SITE: #{site.inspect}"

    @scheduled_chores = site.scheduled_chores

    Rails.logger.info "ScheduledChoresMailer GOT SCHEDULED CHORES"

    #TODO test this away too
    site.site_members.each do |member|
      Rails.logger.info "ScheduledChoresMailer queueing email to: #{member.user.email}"

      mail(
        bcc: site.site_members.map{|m|m.user.email},
        subject: "MaintainIt! It's time to get some chores done!"
      )
    end
  end
end
