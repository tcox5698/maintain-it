class ScheduledChoresMailer < ApplicationMailer

  def chores_email
    site = params[:site]
    puts "GOT SITE: #{site.inspect}"

    @scheduled_chores = site.scheduled_chores

    site.site_members.each do |member|
      mail(to: member.user.email, subject: "MaintainIt! It's time to get some chores done!")
    end
  end
end
