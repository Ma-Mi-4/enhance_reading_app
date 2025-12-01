import "controllers";
import "alpinejs";

// ▼▼▼ Turboを /login だけ完全に止める ▼▼▼
document.addEventListener("turbo:before-fetch-request", (event) => {
  const url = event.detail.url;
  if (url.includes("/login")) {
    console.log("Turbo disabled for /login POST");
    event.preventDefault(); 
  }
});



// Chart.js（UMD を読み込む）
import "chart";
import "chartjs-plugin-annotation";

// Chart.js ロード後の初期化（UMD）
document.addEventListener("DOMContentLoaded", () => {
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
