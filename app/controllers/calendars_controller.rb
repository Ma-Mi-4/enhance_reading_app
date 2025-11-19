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

    records = StudyRecord.where(user: current_user, date: @first_day..@last_day)

    @daily_minutes = records.group(:date).sum(:minutes)
    @daily_accuracy = records.each_with_object({}) { |r, h| h[r.date] = r.accuracy }
    @daily_scores   = records.each_with_object({}) { |r, h| h[r.date] = r.estimated_score }
    @labels = (@first_day..@last_day).map { |d| d.strftime("%m/%d") }
    @data   = (@first_day..@last_day).map { |d| @daily_minutes[d] || 0 }
    @predicted_scores = (@first_day..@last_day).map do |d|
      score = (@daily_scores[d] || 0).to_i
      score < 500 ? 500 : score
    end


    total_minutes = records.sum(:minutes)

    average_accuracy = if records.any?
      records.sum { |r| r.accuracy.to_f } / records.size
    else
      0
    end

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
