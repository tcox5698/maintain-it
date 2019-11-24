# frozen_string_literal: true

class Chore < ApplicationRecord
  belongs_to :site
  after_initialize :populate_defaults
  validates_presence_of :name
  validates :schedule, inclusion: { in: %w[daily],
                                    message: "%{value} is not a supported schedule. Try 'daily'" }

  def populate_defaults
    self.schedule = 'daily' if schedule.blank?
  end

  def already_scheduled?
    Time.use_zone(site.time_zone) do
      ScheduledChore.where('chore_id = ? AND due > ?', id, Time.zone.now).exists?
    end
  end
end

# == Schema Information
#
# Table name: chores
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :string
#  schedule    :string
#  site_id     :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_chores_on_site_id  (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#
