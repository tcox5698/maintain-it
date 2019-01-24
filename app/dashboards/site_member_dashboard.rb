require "administrate/base_dashboard"

class SiteMemberDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    site: Field::BelongsTo,
    id: Field::Number,
    nick_name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    role: Field::String,
    status: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :site,
    :id,
    :nick_name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :site,
    :id,
    :nick_name,
    :created_at,
    :updated_at,
    :role,
    :status,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :site,
    :nick_name,
    :role,
    :status,
  ].freeze

  # Overwrite this method to customize how site members are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(site_member)
  #   "SiteMember ##{site_member.id}"
  # end
end
