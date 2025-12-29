# TOEIC長文トレーニング
サービスURL:https://readskillup.com/
![alt text](image.png)

## サービス概要
TOEIC 600-800点を目標として英語学習をしているが、長文読解だけ点数が伸びない人向けに
1回5-10分のスモールステップ学習で
目標を実現する長文読解特化Webアプリです。

## サービス開発の背景
私自身英語の学習を長く継続してきて、TOEICのテストを受けることがあるのですが、
part7の学習時間の確保を課題に感じていました。
一度学習するのに30分以上の確保が必要なイメージで、単語・文法・リスニングのように隙間時間で学習を進めるのが難しく、その結果、実際のテストでは、時間が足りずに目標スコアに届かないことがありました。
そこで、以下の3点が解決できれば目標スコアにとどくのではないかと考えました。
- Part 7も短時間で継続学習できれば、他のPartと同様にスコアアップできる
- どんなに忙しくても毎日取り組むことが言語学習には必要不可欠
- 1回あたり5-10分ぐらいだと継続しやすい
毎日少しずつ取り組む長文学習を形にしたのが、「TOEIC長文トレーニング」です。

## ターゲットユーザー層について
- 昇進・転職でTOEIC 730点が必要な社会人
- 海外赴任前にTOEIC 800点突破が必要な方
- 就活でTOEIC 600点以上が求められる学生

## サービスの利用イメージ
### 日々仕事で忙しい社会人の方が寝る前に10分を毎日続けるという目標で利用する場合
通知設定をしていれば、今日の学習を促すメッセージの通知をする（ユーザー設定時刻）
通知から直接おすすめ問題に取り組むことができる
一問が解き終わればカレンダーにスタンプを押すことでき、継続できてるかの確認を行うことで達成感を味わえる
問題の正答率やPart 7正答率から推定TOEICスコアを表示することで客観的数字による今回の学習結果を確認できる
今回の問題分析と解説を読んだら今回の問題で理解してほしい単語の復習問題を4択形式で解くことで学習の定着を図る
その後別の問題を続けるかや今日の学習を終えるかの選択をする

## サービスの推しポイント
- **AI最適化による効率学習**：
  AIに最適化された150-200語の問題設計で、
  5-10分で確実に成果が出る学習量を自動調整。
- **復習強制実行システム**：
  読解問題の解答データから重要単語を自動抽出 → 元文章の文脈で
  復習問題を自動生成 → 復習完了まで次の問題ロック。
  技術的な仕組みで「復習の先延ばし」を物理的に防止
- **学習習慣データ化システム**：
  Chart.jsでの学習時間可視化 + ユーザー設定時間の通知で、
  「やめにくい環境」をシステム化

## 機能と使用技術
| 機能                 | 説明                 | 使用技術                                |
| ------------------ | ------------------ | ----------------------------------- |
| ユーザー認証（メール/Google） | メール認証・Google OAuth | Sorcery / Supabase OAuth / SendGrid |
| 長文問題の出題            | JSON → DB → 出題     | Rails / PostgreSQL / Stimulus       |
| タイマー               | 問題の学習時間を自動計測       | Stimulus / JS                       |
| 学習カレンダー            | 毎日の学習時間をグラフ化       | Chart.js + Annotation               |
| 推定スコア表示            | 正答率等から推定           | Railsモデルロジック                        |
| 復習問題               | Part7と連動した語彙問題     | Rails / JSON                        |
| 通知                 | メール通知・リマインダー       | ActionMailer / SendGrid             |
| スマホ対応              | UI最適化              | Tailwind CSS / Alpine.js            |
| デプロイ               | 本番ホスティング           | Fly.io                              |

## 使用技術
### バックエンド・フレームワーク
- Ruby on Rails 7.1（Webアプリケーションフレームワーク）
- PostgreSQL（データベース）
- Sorcery（認証機能）
### フロントエンド
- Tailwind CSS（UIフレームワーク）
- Alpine.js(スマートフォン向け)
- Stimulus + Importmap(タイマー・グラフ表示)
- Turbo / Hotwire
### 開発・デプロイ環境
- Docker（開発環境）
- Fly.io（デプロイ環境）
### 通知・メール機能
- SendGrid（パスワードリセットや変更・通知用メール）
- Action Mailer（メール送信）
### データ可視化
- Chart.js（UMD版） + Annotation プラグイン（グラフ表示）

## ER図
https://drive.google.com/file/d/1akLAn5kkoSvmh6fmhbHIXvF-hglA2TaI/view?usp=sharing

## 画面遷移図
https://www.figma.com/design/3ng9xSuO1X1WmeQX9rvImt/enhance_reading_app_%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=yVgiaaSY4LvS9hra-1

## セットアップ（開発環境）

### 1. リポジトリのクローン
- git clone https://github.com/Ma-Mi-4/enhance_reading_app.git
- cd enhance_reading_app

### 2. Docker を起動
- docker compose build
- docker compose up -d

### 3. データベース作成
- docker compose exec web bin/rails db:create db:migrate

### 4. サーバ起動
- docker compose exec web bin/rails s
