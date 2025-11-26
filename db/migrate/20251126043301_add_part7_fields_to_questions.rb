class AddPart7FieldsToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :choices_text, :jsonb
    add_column :questions, :correct_index, :integer
    add_column :questions, :explanation, :text
    add_column :questions, :wrong_explanations, :jsonb
    add_column :questions, :order, :integer
  end
end
