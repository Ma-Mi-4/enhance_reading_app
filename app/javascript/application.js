console.log("application.js loaded");
import "@hotwired/turbo-rails"
import "bootstrap"
import Alpine from "alpinejs"
import "./timer" 
import "./study_chart"

import Chart from "chart.js/auto";
window.Chart = Chart;


window.Alpine = Alpine
Alpine.start()
