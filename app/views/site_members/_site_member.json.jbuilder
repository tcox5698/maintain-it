# frozen_string_literal: true

json.extract! site_member, :id, :nick_name, :user_id, :site_id, :created_at, :updated_at
json.url site_member_url(site_member, format: :json)
