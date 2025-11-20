class CalendarsController < ApplicationController
  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @first_day = @date.beginning_of_month
    @last_day  = @date.end_of_month
    @first_wday = @first_day.wday
    @days = (@first_day..@last_day).to_a

    records = current_user.study_records.where(date: @first_day..@last_day)

    @study_data = (@first_day..@last_day).map do |d|
      record = records.find { |r| r.date == d }
      {
        label: d.strftime("%m/%d"),
        minutes: record&.minutes || 0,
        predicted_score: record&.estimated_score || 500
      }
    end

    total_minutes = records.sum(:minutes)
    average_accuracy = records.any? ? records.sum { |r| r.accuracy.to_f } / records.size : 0

    predicted_score = 500 + (800 - 500) * average_accuracy
    predicted_score = (predicted_score / 5.0).round * 5

    @month_summary = {
      total_duration: total_minutes,
      predicted_score: predicted_score,
      average_accuracy: (average_accuracy * 100).round(1)
    }
  end

  def show
    @date = Date.parse(params[:date])
    record = StudyRecord.find_by(user: current_user, date: @date)
    @accuracy = record&.accuracy
    @score    = record&.estimated_score
    @minutes  = record&.minutes
  end
end
