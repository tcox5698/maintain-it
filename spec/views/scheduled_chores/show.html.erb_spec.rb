require 'rails_helper'

RSpec.describe "scheduled_chores/show", type: :view do
  let(:chore) {FactoryBot.create(:chore)}

  before(:each) do
    @scheduled_chore = assign(:scheduled_chore, ScheduledChore.create!(
      :due => Time.now,
      :chore => chore,
      :site => chore.site
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
