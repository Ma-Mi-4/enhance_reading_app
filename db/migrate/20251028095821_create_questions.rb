class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.string :level

      t.timestamps
    end
  end
end
