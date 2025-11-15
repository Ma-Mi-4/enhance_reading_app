class AddMinutesToStudyRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :study_records, :minutes, :integer
  end
end
