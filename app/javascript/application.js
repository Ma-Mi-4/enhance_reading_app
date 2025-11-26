console.log("application.js loaded");

import "@hotwired/turbo-rails";
import Alpine from "alpinejs";
import "controllers";

import "timer";
import "study_chart";

import { Chart } from "chart.js";
import "chartjs-plugin-annotation";

if (window['chartjs-plugin-annotation']) {
  Chart.register(window['chartjs-plugin-annotation']);
}

window.Alpine = Alpine;
Alpine.start();
