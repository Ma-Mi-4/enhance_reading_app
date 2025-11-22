console.log("application.js loaded");
import "@hotwired/turbo-rails"
import Alpine from "alpinejs"
import "./timer" 
import "./study_chart"

window.Alpine = Alpine
Alpine.start()
