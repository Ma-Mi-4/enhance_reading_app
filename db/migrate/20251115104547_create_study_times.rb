class CreateStudyTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :study_times do |t|
      t.references :user, null: false, foreign_key: true
      t.string :question_id
      t.integer :seconds
      t.boolean :review

      t.timestamps
    end
  end
end
