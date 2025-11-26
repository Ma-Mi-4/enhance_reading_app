class CreateQuestionSets < ActiveRecord::Migration[7.1]
  def change
    create_table :question_sets do |t|
      t.integer :level
      t.string :title
      t.string :category
      t.text :content
      t.integer :word_count
      t.string :source
      t.jsonb :meta

      t.timestamps
    end
  end
end
