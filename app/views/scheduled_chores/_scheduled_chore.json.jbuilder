json.extract! scheduled_chore, :id, :due, :chore_id, :site_id, :created_at, :updated_at
json.url scheduled_chore_url(scheduled_chore, format: :json)
