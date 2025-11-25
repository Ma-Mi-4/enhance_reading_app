namespace :questions do
  desc "Import Part7 JSON files into DB"
  task import: :environment do
    base_path = Rails.root.join("data", "part7")

    puts "=== Part7 Question Import Started ==="

    Dir.glob("#{base_path}/level*/*.json").each do |file|
      puts "Importing #{file}..."

      begin
        json = JSON.parse(File.read(file))

        question = Question.create!(
          title: json["title"],
          content: json,
          level: json["level"],
          category: json["category"],
          word_count: json["word_count"],
          source: json["source"],
          meta: json["meta"]
        )

        qa = json["questions"].first

        qa["choices_text"].each_with_index do |choice_text, index|
          Choice.create!(
            question_id: question.id,
            body: choice_text,
            correct: (index == qa["correct_index"]),
            explanation:
              if index == qa["correct_index"]
                qa["explanation"]
              else
                qa["wrong_explanations"][index]
              end
          )
        end

        puts "→ Imported Question ##{question.id}"

      rescue StandardError => e
        puts "!! ERROR importing #{file}: #{e.message}"
      end
    end

    puts "=== Import Complete ==="
  end
end
