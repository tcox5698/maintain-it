require 'rails_helper'

RSpec.describe "site_members/show", type: :view do
  before(:each) do
    @site_member = assign(:site_member, SiteMember.create!(
      :nick_name => "Nick Name",
      :user => FactoryGirl.create(:user),
      :site => FactoryGirl.create(:site)
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nick Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
