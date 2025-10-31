namespace :questions do
  desc "JSONファイルをDBに取り込む"
  task import: :environment do
    base_dirs = { "part7" => "part7", "quiz" => "quiz" }

    base_dirs.each do |kind, folder|
      Dir["data/#{folder}/level*/*.json"].each do |file|
        data = JSON.parse(File.read(file))
        level = File.basename(File.dirname(file)).gsub("level","").to_i
        Question.create!(
          title: data["title"] || File.basename(file, ".json"),
          level: level,
          kind: kind,
          content: data
        )
      end
    end
    puts "JSONインポート完了"
  end
end
