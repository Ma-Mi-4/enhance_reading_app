class CreateQuizQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_questions do |t|
      t.references :quiz_set, null: false, foreign_key: true
      t.string :word
      t.string :question_text
      t.jsonb :choices_text
      t.integer :correct_index
      t.string :example_sentence
      t.text :explanation
      t.integer :order

      t.timestamps
    end
  end
end
