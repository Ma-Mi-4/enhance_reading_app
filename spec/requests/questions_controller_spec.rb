require "rails_helper"

RSpec.describe QuestionsController, type: :request do
  let(:user) { create(:user) }
  let(:question_set) { create(:question_set) }
  let!(:question1) { create(:question, question_set: question_set) }
  let!(:question2) { create(:question, question_set: question_set) }

  before do
    login_user(user)
  end

  describe "GET /questions/:id" do
    it "200が返り、問題が表示されること" do
      get question_path(question_set.id)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(question1.body)
    end
  end

  describe "GET /questions/:id（未ログイン）" do
    it "ログインページにリダイレクトされること" do
      logout_user
      get question_path(question_set.id)
      expect(response).to redirect_to(login_path)
    end
  end

  describe "POST /questions/:id/explanation" do
    let(:params) do
      {
        study_seconds: 120,   # 2分
        accuracy: 80          # 80%
      }
    end

    it "StudyRecord が新規作成されること（累積ロジック対応）" do
      expect {
        post explanation_question_path(question_set.id), params: params
      }.to change(StudyRecord, :count).by(1)

      record = StudyRecord.last

      ###
      # ▼ minutes は累積 → 初回は 2 分
      #
      # ▼ accuracy → 質問数が2問
      #   accuracy=80% → correct=1.6 → 四捨五入で2問正解
      #   total=2問
      ###
      expect(record.minutes).to eq(2)
      expect(record.correct_total).to eq(2)
      expect(record.question_total).to eq(2)
      expect(record.accuracy).to eq(100.0)
    end

    it "既に記録がある場合は累積されること" do
      # 1回目：1分 & accuracy 50%（1/2正解）
      initial = StudyRecord.create!(
        user: user,
        date: Date.current,
        minutes: 1,
        correct_total: 1,
        question_total: 2,
        accuracy: 50,   # ← 整数に修正
        predicted_score: 500  # ← 念のため初期値を入れておくと安全
      )

      # 2回目：2分 & accuracy 80%（1.6→2/2正解）
      post explanation_question_path(question_set.id), params: params
      initial.reload

      ###
      # ▼ minutes（累積）
      # 初回1分 + 2分 → 3分
      #
      # ▼ correct_total（累積）
      # 初回 1 + 2 = 3
      #
      # ▼ question_total（累積）
      # 初回 2 + 2 = 4
      #
      # ▼ accuracy（累積）
      # 3 / 4 = 0.75 → 75%
      ###
      expect(initial.minutes).to eq(3)
      expect(initial.correct_total).to eq(3)
      expect(initial.question_total).to eq(4)
      expect(initial.accuracy).to eq(75.0)
    end

    it "処理後に explanation ページへリダイレクトされること" do
      post explanation_question_path(question_set.id), params: params
      expect(response).to redirect_to(explanation_question_path(question_set.id))
    end
  end
end
