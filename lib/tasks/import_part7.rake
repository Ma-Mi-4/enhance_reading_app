namespace :part7 do
  desc "Import Part7 JSON files into QuestionSet & Question"
  task import: :environment do
    base_dir = Rails.root.join("data/part7")

    Dir["#{base_dir}/level*/*.json"].each do |file|
      data = JSON.parse(File.read(file))

      level = data["level"]
      title = data["title"]
      category = data["category"]
      content = data["content"]
      word_count = data["word_count"]
      source  = data["source"]
      meta    = data["meta"] || {}

      question_set = QuestionSet.create!(
        level: level,
        title: title,
        category: category,
        content: content,
        word_count: word_count,
        source: source,
        meta: meta
      )

      puts "Created QuestionSet: #{question_set.title}"

      questions = data["questions"]

      questions.each_with_index do |q, index|
        Question.create!(
          question_set_id: question_set.id,
          body: q["body"] || q["question_text"],
          choices_text: q["choices_text"],
          correct_index: q["correct_index"],
          explanation: q["explanation"],
          wrong_explanations: q["wrong_explanations"],
          order: index + 1
        )
      end

      puts "  → #{questions.size} question imported"
    end

    puts "Part7 import completed!"
  end
end
