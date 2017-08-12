require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}

  let(:valid_attributes) {
    {
      name: 'fake site name'
    }
  }

  let(:invalid_attributes) {
    {
      name: ''
    }
  }

  let(:valid_session) {{}}

  describe "DELETE #destroy" do
    let(:site_member) {FactoryGirl.create(:site_member, user: user)}
    let(:site) {site_member.site}

    context "with authenticated user" do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      context 'site with associated site_member' do
        before do
          expect(site_member.nick_name).to eq 'FactoryGirlSiteMember'
          expect(Site.count).to eq 1
          expect(SiteMember.count).to eq 1
          expect(User.count).to eq 1

          delete :destroy, params: { id: site.to_param }, session: valid_session
        end
        
        it 'deletes the site member' do
          expect(SiteMember.count).to eq 0
        end

        it 'deletes the site' do
          expect(Site.count).to eq 0
        end

        it 'does NOT delete the User' do
          expect(User.count).to eq 1
        end
      end
    end
  end

  describe "POST #create" do


    context "with authenticated user" do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      context "with valid params" do
        before do
          expect(Site.count).to eq 0
          expect(SiteMember.count).to eq 0
          post :create, params: { site: valid_attributes }, session: valid_session
        end

        it "creates a new Site" do
          expect(Site.count).to eq 1
        end

        it "creates a new SiteMember related to the Site and the User" do
          expect(SiteMember.count).to eq 1
          expect(SiteMember.first.site).to eq Site.first
          expect(SiteMember.first.user).to eq User.first
          expect(SiteMember.first.nick_name).to eq 'factorygirl'
        end

        it "redirects to the created site" do
          expect(response).to redirect_to(Site.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { site: invalid_attributes }, session: valid_session
          expect(response).to be_success
        end
      end
    end
  end
end
