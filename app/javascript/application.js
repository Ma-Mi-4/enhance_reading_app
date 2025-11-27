console.log("application.js loaded");

import "@hotwired/turbo-rails";
import Alpine from "alpinejs";
import "controllers";

import "timer";
import "study_chart";

import { Chart } from "chart.js";
import annotationPlugin from "chartjs-plugin-annotation";

Chart.register(annotationPlugin);

window.Alpine = Alpine;
Alpine.start();
