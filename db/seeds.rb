# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


raise "Only seed development environments" unless Rails.env.development?

site = Site.create!(name: 'Seed Site')
user = User.create!(email: 'localdev@example.com', password: 'Password7!', password_confirmation: 'Password7!')
user.skip_confirmation!
user.save()
SiteMember.create!(site: site, user: user, role: 'host', status: 'present')

site.check_in_new_user(email: 'localvisitor@example.com')
