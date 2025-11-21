pin "application", to: "application.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "alpinejs", to: "https://unpkg.com/alpinejs@3.x.x/dist/module.esm.js"

pin "timer", to: "timer.js"

pin "chart.js", to: "vendor/chart.js.js"
pin "@kurkle/color", to: "vendor/@kurkle--color.js"
pin "@popperjs/core", to: "vendor/@popperjs--core.js"
pin "bootstrap", to: "vendor/bootstrap.js"
pin "@rails/ujs", to: "vendor/@rails--ujs.js"

