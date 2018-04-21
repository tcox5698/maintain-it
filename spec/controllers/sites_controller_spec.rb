require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  let(:user) {FactoryBot.create(:user)}
  let(:valid_attributes) {{ name: 'fake site name' }}
  let(:invalid_attributes) {{ name: '' }}
  let(:valid_session) {{}}

  context "some users and sites exist" do
    let(:other_user) {FactoryBot.create(:user, email: "otheruser@example.com")}
    let(:other_site) {FactoryBot.create(:site, name: "other site")}
    let(:other_site_member) {FactoryBot.create(:site_member, user: other_user, site: other_site)}
    let(:site_member) {FactoryBot.create(:site_member, user: user)}
    let(:site) {site_member.site}

    before do
      expect(site.name).to eq 'FactoryBotSite'
      expect(other_site_member.site.name).to eq 'other site'

      expect(site_member.nick_name).to eq 'FactoryBotSiteMember'
      expect(Site.count).to eq 2
      expect(SiteMember.count).to eq 2
      expect(User.count).to eq 2
    end

    describe "GET #show" do
      context "as guest" do
        it "redirects to login" do
          get :show, params: { id: 1 }
          expect(response).to redirect_to("/users/sign_in")
        end
      end

      context "as authenticated user" do
        before do
          allow(request.env['warden']).to receive(:authenticate!).and_return(user)
          allow(controller).to receive(:current_user).and_return(user)
        end

        it "raises Not Found for other users site" do
          expect {get :show, params: { id: other_site.id }}.to raise_error ActiveRecord::RecordNotFound
        end

        it "renders the users site" do
          get :show, params: { id: site.id }
          expect(response.code).to eq "200"
          expect(assigns(:site)).to eq site
        end
      end
    end

    describe "GET #index" do
      context "as guest" do
        it "redirects to login" do
          get :index
          expect(response).to redirect_to("/users/sign_in")
        end
      end

      context "as authenticated user" do
        before do
          allow(request.env['warden']).to receive(:authenticate!).and_return(user)
          allow(controller).to receive(:current_user).and_return(user)
        end

        it "renders only the users sites" do
          get :index
          expect(response.code).to eq "200"
          expect(assigns(:sites).to_ary).to eq [site]
        end
      end
    end

    describe "PUT #update" do
      context "as guest" do
        it "redirects to login" do
          put :update, params: { id: site.id, name: "bob" }
          expect(response).to redirect_to("/users/sign_in")
        end
      end

      context "with authenticated user" do
        before do
          allow(request.env['warden']).to receive(:authenticate!).and_return(user)
          allow(controller).to receive(:current_user).and_return(user)
        end

        context "when other users site" do
          it "raises not found" do
            expect {
              put :update, params: { id: other_site.id, site: { name: "bob" } }
            }.to raise_error ActiveRecord::RecordNotFound
          end
        end

        context "when users site" do
          before do
            put :update, params: { id: site.id, site: { name: "bob" } }
          end

          it "redirects to show" do
            expect(response).to redirect_to("/sites/#{site.id}")
          end

          it "updates the site" do
            site.reload
            expect(site.name).to eq "bob"
          end
        end
      end
    end

    describe "DELETE #destroy" do
      context "with authenticated user" do
        before do
          allow(request.env['warden']).to receive(:authenticate!).and_return(user)
          allow(controller).to receive(:current_user).and_return(user)
        end

        context 'when other users site' do
          it "raises Not Found exception" do
            expect {
              delete :destroy, params: { id: other_site.id }, session: valid_session
            }.to raise_error ActiveRecord::RecordNotFound
          end
        end

        context 'site with associated site_member' do
          before do
            delete :destroy, params: { id: site.to_param }, session: valid_session
          end

          it 'deletes the site member' do
            expect(SiteMember.count).to eq 1
          end

          it 'deletes the site' do
            expect(Site.count).to eq 1
          end

          it 'does NOT delete the User' do
            expect(User.count).to eq 2
          end
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
          expect(SiteMember.first.nick_name).to eq 'factorybot'
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
