require 'rails_helper'

RSpec.describe "SiteMembers", type: :request do
  describe "GET /site_members" do
    it "works! (now write some real specs)" do
      get site_members_path
      expect(response).to have_http_status(200)
    end
  end
end
