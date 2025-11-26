class AddQuestionSetIdToQuizSets < ActiveRecord::Migration[7.1]
  def change
    add_reference :quiz_sets, :question_set, foreign_key: true
  end
end
