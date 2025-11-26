class CreateQuizSets < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_sets do |t|
      t.integer :level
      t.string :title
      t.jsonb :meta

      t.timestamps
    end
  end
end
