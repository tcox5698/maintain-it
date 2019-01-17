class Site < ApplicationRecord
  validates_presence_of :name

  has_many :site_members, dependent: :destroy
  has_many :scheduled_chores

  def check_in_user(email:)
    user = User.find_by_email(email)

    user = create_user(email) unless user

    site_members_rel = user.site_members.where(site_id: self.id)
    if site_members_rel.exists?
      site_member = site_members_rel.first
    else
      site_member =SiteMember.new(user: user, site: self)
    end

    site_member.status = "present"
    site_member.save!

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
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  time_zone  :string           default("America/Chicago")
#
