require 'rails_helper'

RSpec.describe "QuestionsController", type: :request do
  let!(:user) { create(:user) }
  let!(:question_set) { create(:question_set, :with_questions, level: 500, questions_count: 3) }

  describe "GET /questions/:uuid" do
    before { login_user }

    it "ログイン済みなら 200 が返る" do
      get question_path(question_set.uuid)
      expect(response).to have_http_status(:ok)
    end

    it "未ログインでも 200 が返る（stubで current_user が常にあるため）" do
      get question_path(question_set.uuid)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /questions/:uuid/explanation" do
    let(:params) do
      {
        study_seconds: 180,
        accuracy: 80
      }
    end

    it "StudyRecord が新規作成される" do
      expect {
        post explanation_question_path(question_set.uuid), params: params
      }.to change(StudyRecord, :count).by(1)
    end

    it "既存データがあれば minutes が累積される" do
      existing = StudyRecord.create!(
        user: user,
        date: Date.current,
        minutes: 1,
        accuracy: 50,
        predicted_score: 500
      )

      post explanation_question_path(question_set.uuid), params: params

      existing.reload
      expect(existing.minutes).to eq(4)
    end

    it "処理後に explanation ページへリダイレクトされる" do
      post explanation_question_path(question_set.uuid), params: params
      expect(response).to redirect_to(explanation_question_path(question_set.id))
    end
  end
end
