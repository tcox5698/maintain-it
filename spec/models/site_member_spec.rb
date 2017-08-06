require 'rails_helper'

RSpec.describe SiteMember, type: :model do
  context 'when created with user and site' do
    before do
      user = User.create()
    end
    it 'has the input site'
    it 'has the input user'
  end
end
