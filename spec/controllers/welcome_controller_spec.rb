# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'index route', type: :request do
    it 'shows index page' do
      get welcome_index_url
      assert_response 200
    end
  end
end
