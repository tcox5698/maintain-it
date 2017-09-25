class CheckInController < ApplicationController
  before_action :authenticate_user!
  
  def start_visitor
    @sites = current_user.sites
  end
end
