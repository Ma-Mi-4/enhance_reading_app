pin "application", to: "application.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.8/dist/js/bootstrap.esm.js"

pin "alpinejs", to: "https://unpkg.com/alpinejs@3.x.x/dist/module.esm.js"

pin "@rails/ujs", to: "@rails/ujs.js"

pin "timer", to: "timer.js"
pin "chart.js", to: "vendor/javascript/chart.js.js"
pin "@kurkle/color", to: "vendor/javascript/@kurkle/color.js"
