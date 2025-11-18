class StudiesController < ApplicationController
  def dashboard
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week

    @weekly_data = (start_date..end_date).map do |date|
      day_studies = Study.where(user: current_user, date: date)
      duration = day_studies.sum(:duration_min)

      weighted_correct = day_studies.sum { |s| s.correct * s.difficulty }
      max_score = day_studies.sum(&:difficulty)
      weighted_rate = max_score.zero? ? 0 : weighted_correct.to_f / max_score

      predicted_score = 500 + (800 - 500) * weighted_rate
      predicted_score = (predicted_score / 5.0).round * 5

      {
        date: date.strftime("%m/%d"),
        duration: duration,
        predicted_score: predicted_score
      }
    end

    month_start = Date.today.beginning_of_month
    month_end = Date.today.end_of_month
    month_studies = Study.where(user: current_user, date: month_start..month_end)
    month_total_duration = month_studies.sum(:duration_min)
    month_weighted_correct = month_studies.sum { |s| s.correct * s.difficulty }
    month_max_score = month_studies.sum(&:difficulty)
    month_weighted_rate = month_max_score.zero? ? 0 : month_weighted_correct.to_f / month_max_score
    month_predicted_score = 500 + (800-500) * month_weighted_rate
    month_predicted_score = (month_predicted_score / 5.0).round * 5

    @month_summary = {
      total_duration: month_total_duration,
      predicted_score: month_predicted_score
    }

    @chart_data = {
      labels: @weekly_data.map { |d| d[:date] },
      durations: @weekly_data.map { |d| d[:duration] },
      predicted_scores: @weekly_data.map { |d| d[:predicted_score] }
    }
  end
end
