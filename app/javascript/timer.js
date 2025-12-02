if (window.__TIMER_LOADED__) {
  console.log("timer.js already loaded - skip");
}
window.__TIMER_LOADED__ = true;

console.log("timer.js loaded");

let timerInterval = null;

function startTimer() {
  const timerEl = document.getElementById("timer");
  const hiddenEl = document.getElementById("study_seconds");
  if (!timerEl || !hiddenEl) return; // ← ここ重要（ページに timer 無ければ即終了）

  // すでに動いているタイマーがあるなら止める
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

  // このページに timer が無ければ起動しない
  if (!timerEl || !hiddenEl) return;

  console.log("initTimer called");

  // すでに起動済みなら何もしない
  if (timerInterval) return;

  console.log("Calling startTimer...");
  startTimer();
}

// ← ここを 1 つだけにする！
document.addEventListener("DOMContentLoaded", initTimerOnce);
