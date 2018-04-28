require 'rails_helper'

RSpec.describe Site, type: :model do
  it 'validates name is not blank' do
    expect {Site.create!(attributes = { name: '' })}.to raise_error 'Validation failed: Name can\'t be blank'
  end

  it 'lists its site_members' do
    site_member = FactoryBot.create(:site_member)
    expect(Site.first.site_members).to eq [site_member]
  end

  describe "check_in_user" do
    let(:site) {FactoryBot.create(:site)}
    let(:input_email) {"input@example.com"}

    context "when user does not exist" do
      before do
        site.check_in_user(email: input_email)
      end

      it "creates a new user" do
        user = User.find_by_email(input_email)
        expect(user.email).to eq input_email
      end

      describe "user.site member.first" do
        let(:actual_site_member) {User.find_by_email(input_email).site_members.first}
        it "has a site_member associated to the site" do
          actual_site = actual_site_member.site
          expect(actual_site.id).to eq site.id
        end

        it "has status of present" do
          expect(actual_site_member.status).to eq "present"
        end
      end
    end

    context "when user exists" do
      let(:existing_user) {FactoryBot.create(:user, email: input_email)}

      context "when site member does not exist" do
        before do
          expect(existing_user.email).to eq input_email
          site.check_in_user(email: input_email)
        end

        describe "user" do
          it "has a site_member associated to the site" do
            user = User.find_by_email(input_email)
            actual_site = user.site_members.first.site
            expect(actual_site.id).to eq site.id
          end
        end
      end
      
      context "when site member exists" do
        let(:existing_member) {FactoryBot.create(:site_member, user: existing_user, site: site)}

        before do
          expect(existing_member.nick_name).to eq "FactoryBotSiteMember"
          site.check_in_user(email: input_email)
        end

        describe "user" do
          it "has a site_member associated to the site" do
            user = User.find_by_email(input_email)
            actual_site = user.site_members.first.site
            expect(actual_site.id).to eq site.id
          end
        end
      end
    end
  end
end
