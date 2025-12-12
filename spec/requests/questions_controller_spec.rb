require "rails_helper"

RSpec.describe "QuestionsController", type: :request do
  let!(:user) { create(:user) }
  let!(:question_set) { create(:question_set, :with_questions, questions_count: 3) }

  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:require_login)
      .and_return(true)
  end

  describe "GET /questions/:uuid" do
    it "200 が返る" do
      get question_path(question_set.uuid)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /questions/:uuid/explanation" do
    let(:params) { { study_seconds: 180, accuracy: 80 } }

    it "StudyRecord が新規作成される" do
      expect {
        post explanation_question_path(question_set.uuid), params: params
      }.to change(StudyRecord, :count).by(1)
    end

    it "既存データがあれば minutes が累積される" do
      existing = StudyRecord.create!(
        user: user,
        date: Date.current,
        duration: 60,
        minutes: 1,
        accuracy: 50,
        predicted_score: 500
      )

      post explanation_question_path(question_set.uuid), params: params
      expect(existing.reload.minutes).to eq(4)
    end

    it "explanation ページが表示される" do
      post explanation_question_path(question_set.uuid), params: params
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:explanation)
    end
  end
end
