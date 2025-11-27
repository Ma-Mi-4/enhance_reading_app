pin "application"

pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin_all_from "app/javascript/controllers", under: "controllers"

pin "alpinejs", to: "https://unpkg.com/alpinejs@3.x.x/dist/module.esm.js"

pin "timer", to: "timer.js"
pin "study_chart", to: "study_chart.js"

pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js@4.5.1/dist/chart.esm.js"
pin "chartjs-plugin-annotation",
    to: "https://cdn.jsdelivr.net/npm/chartjs-plugin-annotation@4.2.1/dist/chartjs-plugin-annotation.esm.js"
