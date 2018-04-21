require 'rails_helper'

RSpec.describe CheckInController, type: :controller do
  let(:user) {FactoryBot.create(:user)}
  let(:site_member) {FactoryBot.create(:site_member, user: user)}
  let(:site) {site_member.site}
  let(:second_site) {FactoryBot.create(:site, name: 'my other site')}
  let(:second_site_member) {FactoryBot.create(:site_member, user: user, site: second_site)}

  before do
    expect(second_site_member.user).to eq user
    expect(site_member.user).to eq user
  end

  describe 'GET #start_visitor' do
    context 'as guest' do
      it 'redirects to login' do
        get :start_visitor
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'as authenticated user' do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        get :start_visitor
      end

      it 'responds OK' do
        expect(response).to have_http_status(:success)
      end

      #TODO only the users sites where they are the host

      it 'assigns the current users sites' do
        expect(assigns(:sites)).to match_array [site, second_site]
      end
    end
  end

  describe "POST #check_in_visitor" do
    context "as guest" do
      it "redirects to login" do
        post :check_in_visitor
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context "as authenticated user" do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      context "valid site id and email params" do
        before do
          post :check_in_visitor, params: { selected_site: site.id, email: "testvisitor@example.com" }
          @result_user = User.find_by_email("testvisitor@example.com")
        end

        describe "the newly created user" do
          it "has the input email" do
            expect(@result_user).not_to be_nil
            expect(@result_user.email).to eq "testvisitor@example.com"
          end
        end

        describe "the newly created site member" do
          it "user is the newly created member" do
            expect(@result_user.site_members.size).to eq 1
          end

          it "site is the site of the selected id" do
            expect(@result_user.site_members.first.site.id).to eq site.id
          end

          it "nickname is the first part of the email" do
            expect(@result_user.site_members.first.nick_name).to eq "testvisitor"
          end
        end
      end
    end
  end
end
