require 'rails_helper'

RSpec.describe Site, type: :model do
  it 'validates name is not blank' do
    expect {Site.create!(attributes={ name: '' })}.to raise_error 'Validation failed: Name can\'t be blank'
  end

  it 'lists its site_members' do
    site_member = FactoryGirl.create(:site_member)
    
    expect(Site.first.site_members).to eq [site_member]
  end
end
