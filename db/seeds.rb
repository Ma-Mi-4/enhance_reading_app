# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"

# 管理者ユーザー作成（本番・開発・テスト共通）
User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Admin"
  user.password = "password"
  user.password_confirmation = "password"
  user.admin = true
end

puts "✓ Admin user ensured."

# -------------------------------
# Part7 QuestionSet の登録
# -------------------------------
part7_files = Dir.glob(Rails.root.join("data/part7/**/*.json")).sort

part7_files.each do |file|
  content = File.read(file)

  if content.strip.empty?
    puts "⚠ Skipping empty file: #{file}"
    next
  end

  begin
    data = JSON.parse(content)
  rescue JSON::ParserError => e
    puts "⚠ JSON parse error in file #{file}: #{e.message}"
    next
  end

  filename = File.basename(file, ".json")
  set = QuestionSet.find_or_initialize_by(filename: filename)
  set.level = data["level"]
  set.title = data["title"]
  set.save!

  set.questions.delete_all

  data["questions"].each_with_index do |q, idx|
    set.questions.create!(
      order: idx + 1,
      body: q["body"],
      choices_text: q["choices_text"],
      correct_index: q["correct_index"],
      explanation: q["explanation"],
      wrong_explanations: q["wrong_explanations"]
    )
  end

  puts "✓ QuestionSet imported: #{filename}"
end

# -------------------------------
# QuizSet の登録
# -------------------------------
quiz_files = Dir.glob(Rails.root.join("data/quiz/**/*.json")).sort

quiz_files.each do |file|
  content = File.read(file)

  if content.strip.empty?
    puts "⚠ Skipping empty file: #{file}"
    next
  end

  begin
    data = JSON.parse(content)
  rescue JSON::ParserError => e
    puts "⚠ JSON parse error in file #{file}: #{e.message}"
    next
  end

  filename = File.basename(file, ".json")
  question_set_filename = filename.sub("quiz_", "part7_")
  question_set = QuestionSet.find_by(filename: question_set_filename)

  if question_set.nil?
    puts "⚠ QuestionSet not found for #{filename}"
    next
  end

  quiz = QuizSet.find_or_initialize_by(filename: filename)
  quiz.level = data["level"]
  quiz.title = data["title"]
  quiz.question_set = question_set
  quiz.save!

  quiz.quiz_questions.delete_all

  data["questions"].each_with_index do |q, idx|
    quiz.quiz_questions.create!(
      order: idx + 1,
      word: q["word"],
      question_text: q["question_text"],
      choices_text: q["choices_text"],
      correct_index: q["correct_index"]
    )
  end

  puts "✓ QuizSet imported: #{filename}"
end

puts "🎉 Database seed completed!"
