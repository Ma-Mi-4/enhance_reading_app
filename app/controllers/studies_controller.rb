class StudiesController < ApplicationController
  def dashboard
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week

    @weekly_data = (start_date..end_date).map do |date|
      day_records = StudyRecord.where(user: current_user, date: date)
      duration = day_records.sum(:minutes)

      weighted_rate = day_records.any? ? day_records.sum(&:accuracy).to_f / day_records.size : 0

      predicted_score = 500 + (800 - 500) * weighted_rate
      predicted_score = (predicted_score / 5.0).round * 5

      {
        date: date.strftime("%m/%d"),
        duration: duration,
        predicted_score: predicted_score
      }
    end

    month_start = Date.today.beginning_of_month
    month_end   = Date.today.end_of_month
    month_records = StudyRecord.where(user: current_user, date: month_start..month_end)

    month_total_duration = month_records.sum(:minutes)
    month_weighted_rate = month_records.any? ? month_records.sum(&:accuracy).to_f / month_records.size : 0
    month_predicted_score = 500 + (800 - 500) * month_weighted_rate
    month_predicted_score = (month_predicted_score / 5.0).round * 5

    @month_summary = {
      total_duration: month_total_duration,
      predicted_score: month_predicted_score,
      average_accuracy: (month_weighted_rate * 100).round(1)
    }

    @chart_data = {
      labels: @weekly_data.map { |d| d[:date] },
      durations: @weekly_data.map { |d| d[:duration] },
      predicted_scores: @weekly_data.map { |d| d[:predicted_score] }
    }
  end
end
