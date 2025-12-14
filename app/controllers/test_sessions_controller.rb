class TestSessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.find(params[:user_id])
    session[:user_id] = user.id
    head :ok
  end
end
