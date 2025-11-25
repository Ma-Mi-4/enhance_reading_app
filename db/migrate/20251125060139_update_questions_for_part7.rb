class UpdateQuestionsForPart7 < ActiveRecord::Migration[7.1]
  def change
    
    change_column :questions, :level, :integer, using: 'level::integer'

    add_column :questions, :category, :string, null: false, default: "email"
    add_column :questions, :word_count, :integer, null: false, default: 0
    add_column :questions, :source, :string
    add_column :questions, :meta, :jsonb, default: {}
  end
end
