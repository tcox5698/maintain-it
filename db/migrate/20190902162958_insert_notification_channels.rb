# frozen_string_literal: true

class InsertNotificationChannels < ActiveRecord::Migration[5.2]
  def up
    SiteMember.all.each do |site_member|
      site_member.notification_channels << NotificationChannel.new(channel_type: NotificationChannel::TYPE_EMAIL, enabled: true)
    end
  end

  def down
    NotificationChannel.delete_all
  end
end
