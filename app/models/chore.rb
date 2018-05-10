class Chore < ApplicationRecord
  belongs_to :site
  after_initialize :populate_defaults
  validates_presence_of :name
  validates :schedule, inclusion: { in: %w(daily),
                                    message: "%{value} is not a supported schedule. Try 'daily'" }

  def populate_defaults
    self.schedule = "daily" if self.schedule.blank?
  end
end

# == Schema Information
#
# Table name: chores
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  schedule    :string
#  site_id     :integer
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
