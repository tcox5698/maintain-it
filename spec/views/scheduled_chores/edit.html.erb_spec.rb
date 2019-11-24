# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'scheduled_chores/edit', type: :view do
  let(:chore) { FactoryBot.create(:chore) }
  before(:each) do
    @scheduled_chore = assign(:scheduled_chore, ScheduledChore.create!(
                                                  due: Time.now,
                                                  chore: chore,
                                                  site: chore.site
                                                ))
  end

  it 'renders the edit scheduled_chore form' do
    render
    path = scheduled_chore_path(@scheduled_chore)
    assert_select 'form[action=?][method=?]', path, 'post' do
      assert_select 'input[name=?]', 'scheduled_chore[chore_id]'
      assert_select 'input[name=?]', 'scheduled_chore[site_id]'
    end
  end
end
