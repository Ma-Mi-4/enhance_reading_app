class PagesController < ApplicationController
  skip_before_action :require_login, only: [:guide, :faq]

  def guide
  end

  def faq
  end
end
