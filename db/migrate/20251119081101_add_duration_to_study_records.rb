class AddDurationToStudyRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :study_records, :duration, :integer
  end
end
