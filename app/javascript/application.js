import "@hotwired/turbo-rails";
import "controllers";
import "alpinejs";

// Chart.js（UMD を読み込む）
import "chart";
import "chartjs-plugin-annotation";

// Chart.js ロード後の初期化（UMD）
document.addEventListener("turbo:load", () => {
  if (window.Chart && window["chartjs-plugin-annotation"]) {
    console.log("Chart.js & Annotation plugin loaded");
    window.Chart.register(window["chartjs-plugin-annotation"]);
  } else {
    console.error("Chart.js または annotation plugin がロードされていません");
  }
});

// カスタム JS
import "timer";
import "study_chart";
