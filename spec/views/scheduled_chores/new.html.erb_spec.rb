# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'scheduled_chores/new', type: :view do
  let(:chore) { FactoryBot.create(:chore) }
  before(:each) do
    assign(:scheduled_chore, ScheduledChore.new(
                               chore: chore,
                               site: chore.site
                             ))
  end

  it 'renders new scheduled_chore form' do
    render

    assert_select 'form[action=?][method=?]', scheduled_chores_path, 'post' do
      assert_select 'input[name=?]', 'scheduled_chore[chore_id]'

      assert_select 'input[name=?]', 'scheduled_chore[site_id]'
    end
  end
end
