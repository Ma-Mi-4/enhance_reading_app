class QuestionsController < ApplicationController
  skip_before_action :require_login, only: [:show, :explanation], raise: false

  include StudyTimeTracker

  def show
    @question_set = QuestionSet.find_by!(uuid: params[:uuid])
  
    @questions = @question_set.questions.order(:order).map do |q|
      shuffled = q.choices_text.shuffle

      {
        id: q.id,
        body: q.body,
        choices: shuffled,
        correct_index: shuffled.index(q.choices_text[q.correct_index])
      }
    end
    @correct_indexes = @questions.map { |h| h[:correct_index] }
  end

  def explanation
    @question_set = QuestionSet.find_by!(uuid: params[:uuid])

    @questions = @question_set.questions.order(:order).map do |q|
      {
        id: q.id,
        body: q.body,
        choices: q.choices_text,
        correct_index: q.correct_index,
        explanation: q.explanation,
        wrong_explanations: q.wrong_explanations
      }
    end

    seconds = params[:study_seconds].to_i
    accuracy = params[:accuracy].to_i

    today = Date.current
    record = StudyRecord.find_or_initialize_by(user: current_user, date: today)

    # ---- すべての数値項目を確実に0初期化 ----
    record.duration        ||= 0
    record.minutes         ||= 0
    record.correct_total   ||= 0
    record.question_total  ||= 0
    record.accuracy        ||= 0
    record.predicted_score ||= 0

    # ---- 反映 ----
    record.duration += seconds
    record.minutes  = (record.duration / 60.0).floor

    # --- accuracy が無いケースでも保存可能にする ---
    if params[:accuracy].present?
      accuracy_ratio = params[:accuracy].to_f / 100.0

      today_correct = (accuracy_ratio * @questions.length).round
      today_total   = @questions.length

      record.correct_total  += today_correct
      record.question_total += today_total

      if record.question_total > 0
        record.accuracy = (record.correct_total.to_f / record.question_total * 100).round(1)
      else
        record.accuracy = 0
      end

       # ---- predicted score ----
      ratio_all = record.accuracy.to_f / 100.0
      ps = 500 + (800 - 500) * ratio_all
      record.predicted_score = (ps / 5.0).round * 5
    end

    # --- validation 回避：accuracy関連が nil でも save できる ---
    record.save(validate: false)

    render :explanation
  end

  def answer
    save_study_record(
      seconds: params[:study_seconds].to_i,
      accuracy: params[:accuracy]
    )

    redirect_to next_question_path
  end
end
