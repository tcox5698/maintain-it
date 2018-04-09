class SiteMember < ApplicationRecord
  belongs_to :user
  belongs_to :site

  after_initialize :populate_defaults

  validates_presence_of :role

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
#  id         :integer          not null, primary key
#  nick_name  :string
#  user_id    :integer
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :string           default("visitor"), not null
#
# Indexes
#
#  index_site_members_on_site_id  (site_id)
#  index_site_members_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#  fk_rails_...  (user_id => users.id)
#
