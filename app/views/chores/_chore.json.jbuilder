json.extract! chore, :id, :name, :description, :schedule, :created_at, :updated_at
json.url chore_url(chore, format: :json)
