require 'rails_helper'

RSpec.describe "site_members/index", type: :view do
  before(:each) do
    assign(:site_members, [
      SiteMember.create!(
        :nick_name => "Nick Name",
        :user => FactoryGirl.create(:user),
        :site => FactoryGirl.create(:site)
      ),
      SiteMember.create!(
        :nick_name => "Nick Name 2",
        :user => FactoryGirl.create(:user, email: 'different@example.com'),
        :site => FactoryGirl.create(:site)
      )
    ])
  end

  it "renders a list of site_members" do
    render
    assert_select "tr>td", :text => "Nick Name".to_s, :count => 1
    assert_select "tr>td", :text => "Nick Name 2".to_s, :count => 1
  end
end
