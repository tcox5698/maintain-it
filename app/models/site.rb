class Site < ApplicationRecord
  validates_presence_of :name

  has_many :site_members, dependent: :destroy

  def check_in_user(email:)
    user = User.find_by_email(email)

    user = create_user(email) unless user

    member = SiteMember.new(user: user, site: self)

    member.save
    user.send_confirmation_instructions
  end

  private

  def create_user(email)
    random_password = SecureRandom.hex
    user = User.new(email: email,
                    password: random_password,
                    password_confirmation: random_password)
    user.skip_confirmation!
    user.save!
    user
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
