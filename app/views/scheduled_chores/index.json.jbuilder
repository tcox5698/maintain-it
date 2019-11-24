# frozen_string_literal: true

json.array! @scheduled_chores, partial: 'scheduled_chores/scheduled_chore', as: :scheduled_chore
