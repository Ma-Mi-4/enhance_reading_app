class AddFilenameToQuizSets < ActiveRecord::Migration[7.1]
  def change
    add_column :quiz_sets, :filename, :string
    add_index :quiz_sets, :filename, unique: true
  end
end
