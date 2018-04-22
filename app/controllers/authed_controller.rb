class AuthedController < ApplicationController
  before_action :authenticate_user!
end
