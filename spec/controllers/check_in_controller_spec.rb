# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckInController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:site_member) { FactoryBot.create(:site_member, user: user) }
  let(:site) { site_member.site }
  let(:second_site) { FactoryBot.create(:site, name: 'my other site') }
  let(:second_site_member) { FactoryBot.create(:site_member, user: user, site: second_site) }

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
        expect(response).to have_http_status(200)
      end

      # TODO: only the users sites where they are the host

      it 'assigns the current users sites' do
        expect(assigns(:sites)).to match_array [site, second_site]
      end
    end
  end

  describe 'POST #check_in_visitor' do
    context 'as guest' do
      it 'redirects to login' do
        post :check_in_visitor
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'as authenticated user' do
      let(:other_existing_user) { FactoryBot.create(:user, email: 'otheruser@example.com') }
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      context 'user is already a member' do
        let(:other_site_member) { SiteMember.create!(site: site, user: other_user) }

        before do
          input_params = { selected_site: site.id, email: 'otheruser@example.com' }
          post :check_in_visitor, params: input_params
          @result_user = User.find_by_email('otheruser@example.com')
        end

        it 'redirects to site members list' do
          expect(response).to redirect_to '/site_members'
        end

        it 'produces no error messages' do
          expect(flash[:alert]).to be_nil
        end
      end

      context 'user already exists but is not a member' do
        before do
          input_params = { selected_site: site.id, email: 'otheruser@example.com' }
          post :check_in_visitor, params: input_params
          @result_user = User.find_by_email('otheruser@example.com')
        end

        it 'redirects to site members list' do
          expect(response).to redirect_to '/site_members'
        end

        it 'produces no error messages' do
          expect(flash[:alert]).to be_nil
        end

        describe 'the newly created site member' do
          it 'user is the existing user' do
            expect(@result_user.site_members.size).to eq 1
          end

          it 'site is the site of the selected id' do
            expect(@result_user.site_members.first.site.id).to eq site.id
          end

          it 'nickname is the first part of the email' do
            expect(@result_user.site_members.first.nick_name).to eq 'otheruser'
          end
        end
      end

      context 'valid site id and email params' do
        before do
          input_params = { selected_site: site.id, email: 'testvisitor@example.com' }
          post :check_in_visitor, params: input_params
          @result_user = User.find_by_email('testvisitor@example.com')
        end

        it 'redirects to site members list' do
          expect(response).to redirect_to '/site_members'
        end

        it 'produces no error messages' do
          expect(flash[:alert]).to be_nil
        end

        describe 'the newly created site member' do
          it 'user is the newly created member' do
            expect(@result_user.site_members.size).to eq 1
          end

          it 'site is the site of the selected id' do
            expect(@result_user.site_members.first.site.id).to eq site.id
          end

          it 'nickname is the first part of the email' do
            expect(@result_user.site_members.first.nick_name).to eq 'testvisitor'
          end
        end
      end
    end
  end
end
