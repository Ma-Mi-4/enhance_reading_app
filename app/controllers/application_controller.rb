class ApplicationController < ActionController::Base
  include Sorcery::Controller
  before_action :require_login
end
