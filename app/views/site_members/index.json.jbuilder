# frozen_string_literal: true

json.array! @site_members, partial: 'site_members/site_member', as: :site_member
