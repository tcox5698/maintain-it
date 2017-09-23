class Site < ApplicationRecord
  validates_presence_of :name

  has_many :site_members, dependent: :destroy
end

# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
