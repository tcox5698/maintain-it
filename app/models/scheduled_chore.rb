# frozen_string_literal: true

class ScheduledChore < ApplicationRecord
  belongs_to :chore
  belongs_to :site

  after_initialize :populate_due
  validates_presence_of :due

  def populate_due
    return unless due.blank?

    self.due = chore&.next_due_date
  end
end

# == Schema Information
#
# Table name: scheduled_chores
#
#  id         :bigint(8)        not null, primary key
#  due        :datetime
#  chore_id   :bigint(8)
#  site_id    :bigint(8)
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
