# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SiteMembersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/site_members').to route_to('site_members#index')
    end

    it 'routes to #new' do
      expect(get: '/site_members/new').to route_to('site_members#new')
    end

    it 'routes to #show' do
      expect(get: '/site_members/1').to route_to('site_members#show', id: '1')
    end

    it 'routes to #edit' do
      path = '/site_members/1/edit'
      expect(get: path).to route_to('site_members#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/site_members').to route_to('site_members#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/site_members/1').to route_to('site_members#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      path = '/site_members/1'
      expect(patch: path).to route_to('site_members#update', id: '1')
    end

    it 'routes to #destroy' do
      path = '/site_members/1'
      expect(delete: path).to route_to('site_members#destroy', id: '1')
    end
  end
end
