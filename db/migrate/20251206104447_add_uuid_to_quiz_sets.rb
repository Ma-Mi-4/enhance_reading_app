class AddUuidToQuizSets < ActiveRecord::Migration[7.1]
  def change
    add_column :quiz_sets, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index  :quiz_sets, :uuid, unique: true
  end
end
