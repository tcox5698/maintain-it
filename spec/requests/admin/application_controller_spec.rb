# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :request do
  context 'when not logged in' do
    it 'redirects to root with message' do
      get '/admin/users'
      expect(response).to redirect_to(root_url)
      follow_redirect!
      expect(response.body).to include('Try logging in first.')
    end
  end

  context 'when logged in but not admin' do
    let(:user) { FactoryBot.create(:user) }

    before do
      allow_any_instance_of(Admin::UsersController).to receive(:current_user).and_return(user)
    end

    it 'redirects to root with message' do
      get '/admin/users'
      expect(response).to redirect_to(root_url)
      follow_redirect!
      expect(response.body).to include('You are not allowed to do that.')
    end
  end

  context 'when logged in as a sys_admin' do
    let(:user) { FactoryBot.create(:user, sys_admin: true) }

    before do
      allow_any_instance_of(Admin::UsersController).to receive(:current_user).and_return(user)
    end

    it 'renders admin/users route' do
      get '/admin/users'
      expect(response).to render_template(:index)
      expect(response.body).to include(user.email)
    end
  end
end
