class CalendarsController < ApplicationController
  def index
    begin
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
    rescue ArgumentError
      @date = Date.today
    end

    @date = params[:month]&.to_date || Date.today
    @first_day = @date.beginning_of_month
    @last_day  = @date.end_of_month
    @first_wday = @first_day.wday
  end

  def show
    @date = Date.parse(params[:date])

    record = StudyRecord.find_by(user: current_user, date: @date)

    @accuracy = record&.accuracy
    @score    = record&.estimated_score
  end
end

