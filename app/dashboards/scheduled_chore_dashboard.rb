require "administrate/base_dashboard"

class ScheduledChoreDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    chore: Field::BelongsTo,
    site: Field::BelongsTo,
    id: Field::Number,
    due: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :chore,
    :site,
    :id,
    :due,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :chore,
    :site,
    :id,
    :due,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :chore,
    :site,
    :due,
  ].freeze

  # Overwrite this method to customize how scheduled chores are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(scheduled_chore)
  #   "ScheduledChore ##{scheduled_chore.id}"
  # end
end
