import { Chart } from "chart.js";

let studyChart;

function initStudyChart() {
  const canvas = document.getElementById("studyChart");
  if (!canvas) return;

  const parsed = JSON.parse(canvas.dataset.study);

  if (studyChart) studyChart.destroy();

  studyChart = new Chart(canvas, {
    type: "bar",
    data: {
      labels: parsed.labels,
      datasets: [{
        label: "学習時間（分）",
        data: parsed.values,
        backgroundColor: "rgba(54, 162, 235, 0.5)"
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false
    }
  });
}

document.addEventListener("turbo:load", initStudyChart);
