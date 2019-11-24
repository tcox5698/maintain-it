# frozen_string_literal: true

class NotificationChannel < ApplicationRecord
  TYPE_EMAIL = 'email'

  belongs_to :site_member
end

# == Schema Information
#
# Table name: notification_channels
#
#  id             :bigint(8)        not null, primary key
#  channel_type   :string
#  enabled        :boolean
#  site_member_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_notification_channels_on_site_member_id  (site_member_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_member_id => site_members.id)
#
