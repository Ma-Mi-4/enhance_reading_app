pin "application", preload: true

# Hotwire
pin "@hotwired/turbo-rails", to: "@hotwired/turbo-rails.js", preload: true
pin "@hotwired/turbo",       to: "@hotwired/turbo.js", preload: true
pin "@rails/actioncable/src", to: "@rails/actioncable/src.js", preload: true

pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# Alpine.js（UMD版）
pin "alpinejs", to: "https://cdn.jsdelivr.net/npm/alpinejs@3.13.1/dist/cdn.min.js"

# Chart.js（最重要）
pin "chart", to: "chart.js"                     # ← ★chart.js ではない！chart！
pin "chartjs-plugin-annotation", to: "chartjs-plugin-annotation.js"
pin "@kurkle/color", to: "@kurkle--color.js"

# Custom JS
pin "timer", to: "timer.js"
pin "study_chart", to: "study_chart.js"
