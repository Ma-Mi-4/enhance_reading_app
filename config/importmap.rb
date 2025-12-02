pin "application", preload: true

# --- Turbo ---
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.20
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.20

# --- Stimulus ---
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# --- Alpine.js ---
pin "alpinejs", to: "https://cdn.jsdelivr.net/npm/alpinejs@3.13.1/dist/cdn.min.js"

# --- Chart.js ---
pin "chart", to: "chart.js"
pin "chartjs-plugin-annotation", to: "chartjs-plugin-annotation.js"
pin "@kurkle/color", to: "@kurkle--color.js"

# --- Custom JS ---
pin "timer", to: "timer.js"
pin "study_chart", to: "study_chart.js"
pin "question_quiz", to: "question_quiz.js"
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @8.1.100
