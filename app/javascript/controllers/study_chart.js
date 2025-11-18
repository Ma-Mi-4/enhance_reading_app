import Chart from "chart.js/auto";

document.addEventListener("turbo:load", () => {
  const canvas = document.getElementById("studyChart");
  if (!canvas) return;

  const parsed = JSON.parse(canvas.dataset.chart);

  const data = {
    labels: parsed.labels,
    datasets: [
      {
        label: "学習時間（分）",
        data: parsed.durations,
        type: "bar",
        backgroundColor: "rgba(54, 162, 235, 0.5)",
        yAxisID: "y",
      },
      {
        label: "予想スコア",
        data: parsed.predicted_scores,
        type: "line",
        borderColor: "rgba(255, 99, 132, 1)",
        backgroundColor: "rgba(255, 99, 132, 0.2)",
        yAxisID: "y1",
        tension: 0.3,
        fill: false
      }
    ]
  };

  const options = {
    responsive: true,
    interaction: {
      mode: 'index',
      intersect: false
    },
    stacked: false,
    plugins: {
      legend: {
        position: "top"
      },
    },
    scales: {
      y: {
        type: "linear",
        display: true,
        position: "left",
        title: { display: true, text: "学習時間（分）" }
      },
      y1: {
        type: "linear",
        display: true,
        position: "right",
        title: { display: true, text: "予想スコア" },
        min: 500,
        max: 800,
        ticks: {
          stepSize: 50
        },
        grid: {
          drawOnChartArea: false
        }
      }
    },
    plugins: {
      annotation: {
        annotations: {
          score500: { type: "line", yMin: 500, yMax: 500, borderColor: "gray", borderDash: [6,6], label: { enabled: true, content: "500点", position: "end" }},
          score600: { type: "line", yMin: 600, yMax: 600, borderColor: "gray", borderDash: [6,6], label: { enabled: true, content: "600点", position: "end" }},
          score700: { type: "line", yMin: 700, yMax: 700, borderColor: "gray", borderDash: [6,6], label: { enabled: true, content: "700点", position: "end" }},
          score800: { type: "line", yMin: 800, yMax: 800, borderColor: "gray", borderDash: [6,6], label: { enabled: true, content: "800点", position: "end" }},
        }
      }
    }
  };

  new Chart(canvas, { data, options });
});
