namespace :quiz do
  desc "Import quiz JSON files into QuizSet & QuizQuestion"
  task import: :environment do
    base_dir = Rails.root.join("data/quiz")

    Dir["#{base_dir}/level*/*.json"].each do |file|
      data = JSON.parse(File.read(file))

      level = data["level"]
      title = data["title"]
      meta  = data["meta"] || {}

      quiz_set = QuizSet.create!(
        level: level,
        title: title,
        meta: meta
      )

      puts "Created QuizSet: #{quiz_set.title}"

      data["questions"].each_with_index do |q, index|
        QuizQuestion.create!(
          quiz_set: quiz_set,
          word: q["word"],
          question_text: q["question_text"],
          choices_text: q["choices_text"],
          correct_index: q["correct_index"],
          example_sentence: q["example_sentence"],
          explanation: q["explanation"],
          order: index + 1
        )
      end

      puts "  → #{quiz_set.quiz_questions.count} questions imported"
    end

    puts "Quiz import completed!"
  end
end
