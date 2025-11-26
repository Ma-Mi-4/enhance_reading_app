class RenameEstimatedScoreToPredictedScoreInStudyRecords < ActiveRecord::Migration[7.1]
  def change
    rename_column :study_records, :estimated_score, :predicted_score
  end
end
