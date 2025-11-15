import { Chart } from "chart.js/auto";

let studyChart;

document.addEventListener("turbo:load", () => {
  const ctx = document.getElementById("studyChart");
  if (!ctx) return;

  if (studyChart) {
    studyChart.destroy();
  }

  const data = JSON.parse(ctx.dataset.study);

  studyChart = new Chart(ctx, {
    type: "bar",
    data: {
      labels: data.labels,
      datasets: [{
        label: "学習時間",
        data: data.values
      }]
    },
    options: {}
  });
});
