# frozen_string_literal: true

class AuthedController < ApplicationController
  before_action :authenticate_user!
end
