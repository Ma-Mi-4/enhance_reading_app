class Admin::QuestionsController < Admin::ApplicationController
  layout "admin"
  before_action :set_question, only: [:edit, :update, :destroy, :show]

  def index
    @questions = Question.order(:level)
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