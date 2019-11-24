# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScheduledChoresController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/scheduled_chores').to route_to('scheduled_chores#index')
    end

    it 'routes to #new' do
      expect(get: '/scheduled_chores/new').to route_to('scheduled_chores#new')
    end

    it 'routes to #show' do
      expect(get: '/scheduled_chores/1').to route_to('scheduled_chores#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/scheduled_chores/1/edit').to route_to('scheduled_chores#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/scheduled_chores').to route_to('scheduled_chores#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/scheduled_chores/1').to route_to('scheduled_chores#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/scheduled_chores/1').to route_to('scheduled_chores#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/scheduled_chores/1').to route_to('scheduled_chores#destroy', id: '1')
    end
  end
end
