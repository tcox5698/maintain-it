require 'rails_helper'

RSpec.describe "site_members/edit", type: :view do
  before(:each) do
    @site_member = assign(:site_member, SiteMember.create!(
      :nick_name => 'Fake Nick Name',
      :user => FactoryGirl.create(:user),
      :site => FactoryGirl.create(:site)
    ))
  end

  it "renders the edit site_member form" do
    render

    assert_select "form[action=?][method=?]", site_member_path(@site_member), "post" do

      assert_select "input[name=?]", "site_member[nick_name]"

      assert_select "input[name=?]", "site_member[user_id]"

      assert_select "input[name=?]", "site_member[site_id]"
    end
  end
end
