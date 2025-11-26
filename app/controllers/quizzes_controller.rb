class QuizzesController < ApplicationController
  before_action :require_login
  include StudyTimeTracker

  def show
    @quiz_set = QuizSet.find(params[:id])

    @questions = @quiz_set.quiz_questions.order(:order).map do |q|
      shuffled = q.choices_text.shuffle

      {
        id: q.id,
        word: q.word,
        question_text: q.question_text,
        choices: shuffled,
        correct_index: shuffled.index(q.choices_text[q.correct_index]),
        explanation: q.explanation,
        example_sentence: q.example_sentence
      }
    end
  end

  def explanation
    @quiz_set = QuizSet.find(params[:id])

    @questions = @quiz_set.quiz_questions.order(:order).map do |q|
      {
        id: q.id,
        question_text: q.question_text,
        choices: q.choices_text,
        correct_index: q.correct_index,
        explanation_list: q.explanation.to_s.split("\n"),
        example_sentence: q.example_sentence
      }
    end


    seconds = params[:study_seconds].to_i
    minutes = (seconds / 60.0).round
    today = Date.current

    record = StudyRecord.find_or_initialize_by(user: current_user, date: today)
    record.minutes ||= 0
    record.minutes += minutes

    if params[:accuracy].present?
      record.accuracy = params[:accuracy].to_f
      record.estimated_score = 500 + (800 - 500) * record.accuracy
      record.estimated_score = (record.estimated_score / 5.0).round * 5
    end

    record.save
  end

  def answer
    save_study_record(
      seconds: params[:study_seconds].to_i,
      accuracy: params[:accuracy],
      review: true
    )

    redirect_to next_quiz_path
  end
end
