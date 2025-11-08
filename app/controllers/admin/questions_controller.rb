class Admin::QuestionsController < Admin::ApplicationController
  layout "admin"
  before_action :set_question, only: [:edit, :update, :destroy, :show]

  def index
    @questions = Question.order(:level)

    @json_questions = []
    %w[part7 quiz].each do |category|
      Dir[Rails.root.join("data/#{category}/level*/#{category}_level*_*.json")].each do |file_path|
        begin
          quiz_data = JSON.parse(File.read(file_path))
          quiz_data["category"] = category
          quiz_data["file_path"] = file_path
          @json_questions << quiz_data
        rescue JSON::ParserError
          next
        end
      end
    end

    db_titles = @questions.pluck(:title)
    @json_questions.reject! { |q| db_titles.include?(q["title"]) }

    @all_questions = (@questions.map { |q| q.attributes.merge("source" => "db", "level" => q.level.to_i) } +
                      @json_questions.map { |q| q.merge("source" => "json", "level" => q["level"].to_i) })
                     .sort_by { |q| q["level"] }

  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.content = JSON.parse(params[:question][:content]) rescue {}
    if @question.save
      redirect_to admin_questions_path, notice: "問題を作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @question.content = JSON.parse(params[:question][:content]) rescue {}
    if @question.update(question_params.except(:content))
      redirect_to admin_questions_path, notice: "問題を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_questions_path, notice: "問題を削除しました" }
      format.turbo_stream
    end
  end

  def show
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :level, :kind, :content)
  end
end