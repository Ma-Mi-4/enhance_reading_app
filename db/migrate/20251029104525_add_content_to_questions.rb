class AddContentToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :content, :json
  end
end
