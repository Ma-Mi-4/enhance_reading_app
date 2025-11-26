class AddCorrectAndQuestionToStudyRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :study_records, :correct_total, :integer
    add_column :study_records, :question_total, :integer
  end
end
