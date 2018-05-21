class ScheduledChore < ApplicationRecord
  belongs_to :chore
  belongs_to :site

  validates_presence_of :due
end

# == Schema Information
#
# Table name: scheduled_chores
#
#  id         :integer          not null, primary key
#  due        :datetime
#  chore_id   :integer
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_scheduled_chores_on_chore_id  (chore_id)
#  index_scheduled_chores_on_site_id   (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (chore_id => chores.id)
#  fk_rails_...  (site_id => sites.id)
#
