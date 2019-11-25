# frozen_string_literal: true

class ScheduleChoresJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Chore.all.each do |chore|
      next if chore.already_scheduled?

      ScheduledChore.create!(chore: chore, site: chore.site)
    end
  end
end
