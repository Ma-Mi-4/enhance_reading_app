pin "application", preload: true

pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js", preload: true
pin "@hotwired/turbo", to: "@hotwired--turbo.js"

# --- Stimulus ---
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# --- Chart.js ---
pin "chart", to: "chart.js"
pin "chartjs-plugin-annotation", to: "chartjs-plugin-annotation.js"
pin "@kurkle/color", to: "@kurkle--color.js"

# --- Custom JS ---
pin "timer", to: "timer.js"
pin "study_chart", to: "study_chart.js"
pin "question_quiz", to: "question_quiz.js"
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @8.1.100
