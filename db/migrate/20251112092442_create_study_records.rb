class CreateStudyRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :study_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.integer :accuracy
      t.integer :estimated_score

      t.timestamps
    end
  end
end
