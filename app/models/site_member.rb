class SiteMember < ApplicationRecord
  belongs_to :user
  belongs_to :site
  has_many :notification_channels, dependent: :destroy

  after_initialize :populate_defaults
  after_create :initialize_channels

  validates_presence_of :role

  def initialize_channels
    self.notification_channels << NotificationChannel.new(channel_type: NotificationChannel::TYPE_EMAIL, enabled: true)
  end

  def notification_channel_enabled?(channel_type)
    notification_channel(channel_type)&.enabled
  end

  def notification_channel(channel_type)
    self.notification_channels.find { |channel| channel.channel_type == channel_type }
  end

  def populate_defaults
    self.populate_nick_name
    self.populate_role
  end

  def populate_role
    if self.role.blank?
      self.role = 'visitor'
    end
  end

  def populate_nick_name
    if self.user
      self.nick_name = self.user.email.split("@")[0] if self.nick_name.blank?
    end
  end
end

# == Schema Information
#
# Table name: site_members
#
#  id         :bigint(8)        not null, primary key
#  nick_name  :string
#  user_id    :bigint(8)
#  site_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :string           default("visitor"), not null
#  status     :string           default("absent"), not null
#
# Indexes
#
#  index_site_members_on_site_id              (site_id)
#  index_site_members_on_user_id              (user_id)
#  index_site_members_on_user_id_and_site_id  (user_id,site_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#  fk_rails_...  (user_id => users.id)
#
