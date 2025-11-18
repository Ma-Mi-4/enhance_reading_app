class CalendarsController < ApplicationController
  def index
    begin
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
    rescue ArgumentError
      @date = Date.today
    end

    @first_day = @date.beginning_of_month
    @last_day  = @date.end_of_month
    @first_wday = @first_day.wday

    @days = (@first_day..@last_day).to_a

    start_date = @date.beginning_of_month
    end_date   = @date.end_of_month

    records = StudyRecord.where(user: current_user, date: start_date..end_date)
    @daily_minutes = records.group(:date).sum(:minutes)

    @labels = (start_date..end_date).map { |d| d.strftime("%m/%d") }
    @data   = (start_date..end_date).map { |d| @daily_minutes[d] || 0 }
  end

  def show
    @date = Date.parse(params[:date])

    record = StudyRecord.find_by(user: current_user, date: @date)

    @accuracy = record&.accuracy
    @score    = record&.estimated_score
  end
end

