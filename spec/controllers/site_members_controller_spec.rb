# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SiteMembersController, type: :controller do
  let(:user) { FactoryBot.create(:user, email: 'someuser@example.com') }

  # This should return the minimal set of attributes required to create a valid
  # SiteMember. As you add validations to SiteMember, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      nick_name: 'fake nick name',
      user_id: FactoryBot.create(:user).id,
      site_id: FactoryBot.create(:site).id
    }
  end

  let(:invalid_attributes) do
    { user_id: nil }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SiteMembersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  context 'with authenticated user' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET #index' do
      it 'returns a success response' do
        SiteMember.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do
      it 'returns a success response' do
        site_member = SiteMember.create! valid_attributes
        get :show, params: { id: site_member.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #edit' do
      it 'returns a success response' do
        site_member = SiteMember.create! valid_attributes
        get :edit, params: { id: site_member.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new SiteMember' do
          expect do
            post :create, params: { site_member: valid_attributes }, session: valid_session
          end.to change(SiteMember, :count).by(1)
        end

        it 'redirects to the created site_member' do
          post :create, params: { site_member: valid_attributes }, session: valid_session
          expect(response).to redirect_to(SiteMember.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { site_member: invalid_attributes }, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) do
          { nick_name: 'new nick name' }
        end

        it 'updates the requested site_member' do
          site_member = SiteMember.create! valid_attributes
          input_params = { id: site_member.to_param, site_member: new_attributes }
          put :update, params: input_params, session: valid_session
          site_member.reload
          expect(site_member.nick_name).to eq 'new nick name'
        end

        it 'redirects to the site_member' do
          site_member = SiteMember.create! valid_attributes
          input_params = { id: site_member.to_param, site_member: valid_attributes }
          put :update, params: input_params, session: valid_session
          expect(response).to redirect_to(site_member)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          site_member = SiteMember.create! valid_attributes
          input_params = { id: site_member.to_param, site_member: invalid_attributes }
          put :update, params: input_params, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested site_member' do
        site_member = SiteMember.create! valid_attributes
        expect do
          delete :destroy, params: { id: site_member.to_param }, session: valid_session
        end.to change(SiteMember, :count).by(-1)
      end

      it 'redirects to the site_members list' do
        site_member = SiteMember.create! valid_attributes
        delete :destroy, params: { id: site_member.to_param }, session: valid_session
        expect(response).to redirect_to(site_members_url)
      end
    end
  end
end
