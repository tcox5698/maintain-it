# frozen_string_literal: true

json.array! @chores, partial: 'chores/chore', as: :chore
