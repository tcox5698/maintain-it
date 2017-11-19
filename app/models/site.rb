class Site < ApplicationRecord
  validates_presence_of :name

  has_many :site_members, dependent: :destroy

  def check_in_new_user(email:)
    random_password = SecureRandom.hex
    user = User.new(email: email,
                    password: random_password,
                    password_confirmation: random_password)
    user.skip_confirmation!
    user.save

    member = SiteMember.new(user: user, site: self, nick_name: "blah")

    member.save
    user.send_confirmation_instructions
  end
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
