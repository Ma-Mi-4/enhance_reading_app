namespace :quiz do
  desc "Import quiz JSON files into QuizSet & QuizQuestion (with QuestionSet linking)"
  task import: :environment do
    base_dir = Rails.root.join("data/quiz")

    Dir["#{base_dir}/level*/*.json"].each do |file|
      data = JSON.parse(File.read(file))

      level = data["level"]
      title = data["title"]
      meta  = data["meta"] || {}

      # ------- 番号の抽出 -------
      filename = File.basename(file, ".json")       # "quiz_level500_001"
      index_str = filename.split("_").last          # "001"
      index_num = index_str.to_i                    # 1〜10 に変換

      # ------- 対応する QuestionSet を検索 -------
      # level が同じ QuestionSet を並び順で対応させる
      question_set = QuestionSet.where(level: level).order(:id).offset(index_num - 1).first

      if question_set.nil?
        puts "対応する QuestionSet が見つかりません: #{file}"
        next
      end

      # ------- QuizSet を作成（紐付け付き） -------
      quiz_set = QuizSet.create!(
        level: level,
        title: title,
        meta: meta,
        question_set: question_set
      )

      puts "Created QuizSet: #{quiz_set.title} → QuestionSet ##{question_set.id}"

      # ------- QuizQuestion の作成 -------
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
