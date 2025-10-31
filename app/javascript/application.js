import "@hotwired/turbo-rails"
import "bootstrap"
import "controllers"
import Alpine from "alpinejs"
import Rails from "@rails/ujs"

Rails.start()
window.Alpine = Alpine
Alpine.start()
