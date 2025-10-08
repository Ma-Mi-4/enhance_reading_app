class QuestionsController < ApplicationController
  before_action :require_login

  def index
    @question = "これは仮の問題です"
    @choices = ["A", "B", "C", "D"]
  end
end
