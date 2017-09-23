require 'rails_helper'

RSpec.describe "site_members/new", type: :view do
  before(:each) do
    assign(:site_member, SiteMember.new(
      :nick_name => "MyString",
      :user => nil,
      :site => nil
    ))
  end

  it "renders new site_member form" do
    render

    assert_select "form[action=?][method=?]", site_members_path, "post" do

      assert_select "input[name=?]", "site_member[nick_name]"

      assert_select "input[name=?]", "site_member[user_id]"

      assert_select "input[name=?]", "site_member[site_id]"
    end
  end
end
