class AddKindToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :kind, :string
  end
end
