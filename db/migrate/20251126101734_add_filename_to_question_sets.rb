class AddFilenameToQuestionSets < ActiveRecord::Migration[7.1]
  def change
    add_column :question_sets, :filename, :string
    add_index :question_sets, :filename, unique: true
  end
end
