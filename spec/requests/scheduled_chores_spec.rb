require 'rails_helper'

RSpec.describe "ScheduledChores", type: :request do
  describe "GET /scheduled_chores" do
    it "works! (now write some real specs)" do
      get scheduled_chores_path
      expect(response).to have_http_status(200)
    end
  end
end
