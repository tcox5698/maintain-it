class SiteMember < ApplicationRecord
  belongs_to :user
  belongs_to :site
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
