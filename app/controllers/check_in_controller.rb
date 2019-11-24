# frozen_string_literal: true

class CheckInController < AuthedController
  def start_visitor
    @sites = current_user.sites
  end

  def check_in_visitor
    email, site_id = check_in_visitor_params

    site = Site.find(site_id)
    site.check_in_user(email: email)

    redirect_to site_members_url
  end

  def check_in_visitor_params
    params.require(%i[email selected_site])
  end
end
