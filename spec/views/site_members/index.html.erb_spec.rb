require 'rails_helper'

RSpec.describe "site_members/index", type: :view do
  before(:each) do
    assign(:site_members, [
      SiteMember.create!(
        :nick_name => "Nick Name",
        :user => nil,
        :site => nil
      ),
      SiteMember.create!(
        :nick_name => "Nick Name",
        :user => nil,
        :site => nil
      )
    ])
  end

  it "renders a list of site_members" do
    render
    assert_select "tr>td", :text => "Nick Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
