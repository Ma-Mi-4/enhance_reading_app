document.addEventListener("DOMContentLoaded", () => {
  // Chart.js と annotation plugin がロードされているか確認
  if (!window.Chart) {
    console.error("Chart.js がロードされていません");
    return;
  }
  if (!window['chartjs-plugin-annotation']) {
    console.error("chartjs-plugin-annotation がロードされていません");
    return;
  }

  window.Chart.register(window['chartjs-plugin-annotation']);

  const canvas = document.getElementById("studyChart");
  if (!canvas) return;

  const parsed = JSON.parse(canvas.dataset.study || "[]");
  if (!parsed.length) return;

  const labels = parsed.map(d => d.label);
  const durations = parsed.map(d => d.minutes);
  const predicted_scores = parsed.map(d => d.predicted_score);

  if (canvas.chartInstance) canvas.chartInstance.destroy();

  canvas.chartInstance = new Chart(canvas, {
    data: {
      labels: labels,
      datasets: [
        {
          label: "学習時間（分）",
          data: durations,
          type: "bar",
          backgroundColor: "rgba(54, 162, 235, 0.5)",
          yAxisID: "y",
        },
        {
          label: "予想スコア",
          data: predicted_scores,
          type: "line",
          borderColor: "rgba(255, 99, 132, 1)",
          backgroundColor: "rgba(255, 99, 132, 0.2)",
          yAxisID: "y1",
          tension: 0.3,
          fill: false
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: false,
      interaction: {
        mode: 'index',
        intersect: false
      },
      stacked: false,
      plugins: {
        legend: { position: window.innerWidth < 500 ? "bottom" : "top" },
        annotation: {
          annotations: {
            score500: { type: "line", yMin: 500, yMax: 500, borderColor: "gray", borderDash: [6, 6], label: { enabled: true, content: "500点", position: "end" }},
            score600: { type: "line", yMin: 600, yMax: 600, borderColor: "gray", borderDash: [6, 6], label: { enabled: true, content: "600点", position: "end" }},
            score700: { type: "line", yMin: 700, yMax: 700, borderColor: "gray", borderDash: [6, 6], label: { enabled: true, content: "700点", position: "end" }},
            score800: { type: "line", yMin: 800, yMax: 800, borderColor: "gray", borderDash: [6, 6], label: { enabled: true, content: "800点", position: "end" }},
          }
        }
      },
      scales: {
        x:{
          ticks:{
            callback:function(_, index){
              if(window.innerWidth < 500){
                return index % 4 === 0 ? this.getLabelForValue(index) : "";
              }
              return this.getLabelForValue(index);
            }
          }
        },
        y: { type: "linear", position: "left", title: { display: true, text: "学習時間（分）" }, ticks: { beginAtZero: true, stepSize: 10 } },
        y1: { type: "linear", position: "right", title: { display: true, text: "予想スコア" }, min: 500, max: 800, ticks: { stepSize: 50 }, grid: { drawOnChartArea: false } }
      }
    }
  });
});
