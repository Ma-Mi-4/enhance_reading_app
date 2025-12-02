if (window.__TIMER_LOADED__) {
  console.log("timer.js already loaded - skip");
}
window.__TIMER_LOADED__ = true;

console.log("timer.js loaded");

let timerInterval = null;

function startTimer() {
  const timerEl = document.getElementById("timer");
  const hiddenEl = document.getElementById("study_seconds");
  if (!timerEl || !hiddenEl) return;

  if (timerInterval) {
    clearInterval(timerInterval);
    timerInterval = null;
  }

  let totalSeconds = Number(hiddenEl.value) || 0;

  timerInterval = setInterval(() => {
    totalSeconds += 1;
    hiddenEl.value = totalSeconds;

    const m = String(Math.floor(totalSeconds / 60)).padStart(2, "0");
    const s = String(totalSeconds % 60).padStart(2, "0");
    timerEl.textContent = `${m}:${s}`;
  }, 1000);

  console.log("timer started");
}

window.startTimer = startTimer;

window.stopTimer = function () {
  console.log("stopTimer called");
  if (timerInterval) clearInterval(timerInterval);
  timerInterval = null;
};

function initTimerOnce() {
  const timerEl = document.getElementById("timer");
  const hiddenEl = document.getElementById("study_seconds");

  if (!timerEl || !hiddenEl) return;

  console.log("initTimer called");

  if (timerInterval) return;

  console.log("Calling startTimer...");
  startTimer();
}

// ページロード時
document.addEventListener("DOMContentLoaded", initTimerOnce);

// ★ 追加：フォーム送信時に確実に stopTimer() ★
document.addEventListener("turbo:submit-start", () => {
  console.log("turbo:submit-start detected → stopTimer()");
  window.stopTimer();
});

document.addEventListener("submit", () => {
  console.log("submit detected → stopTimer()");
  window.stopTimer();
});
