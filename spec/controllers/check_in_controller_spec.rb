require 'rails_helper'

RSpec.describe CheckInController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:site_member) {FactoryGirl.create(:site_member, user: user)}
  let(:site) {site_member.site}
  let(:second_site) {FactoryGirl.create(:site, name: 'my other site')}
  let(:second_site_member) {FactoryGirl.create(:site_member, user: user, site: second_site)}

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

      it 'assigns the current users sites' do
        expect(assigns(:sites)).to match_array [site, second_site]
      end
    end
  end

end
