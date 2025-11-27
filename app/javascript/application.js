console.log("application.js loaded");

import "@hotwired/turbo-rails";
import "controllers";

import Alpine from "alpinejs";
window.Alpine = Alpine;
Alpine.start();

import "timer";
import "study_chart";

import { Chart } from "chart.js";
import annotationPlugin from "chartjs-plugin-annotation";

Chart.register(annotationPlugin);
