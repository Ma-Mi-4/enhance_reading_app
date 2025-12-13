class TestSessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.find(params[:user_id])
    auto_login(user)
    head :ok
  end
end
