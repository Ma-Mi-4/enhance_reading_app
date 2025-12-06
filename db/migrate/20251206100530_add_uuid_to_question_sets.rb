class AddUuidToQuestionSets < ActiveRecord::Migration[7.1]
  def change
    add_column :question_sets, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :question_sets, :uuid, unique: true
  end
end
