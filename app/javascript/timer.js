console.log("timer.js loaded");

let timerInterval = null;
let totalSeconds = 0;

window.startTimer = function() {
  const timerEl = document.getElementById("timer");
  const hiddenEl = document.getElementById("study_seconds");
  if (!timerEl || !hiddenEl) return;

  if (timerInterval) clearInterval(timerInterval);

  timerInterval = setInterval(() => {
    totalSeconds += 1;
    const m = String(Math.floor(totalSeconds / 60)).padStart(2, "0");
    const s = String(totalSeconds % 60).padStart(2, "0");
    timerEl.textContent = `${m}:${s}`;
    hiddenEl.value = totalSeconds;
    console.log("timer running:", m, s);
  }, 1000);

  console.log("timer started");
};

window.stopTimer = function() {
  console.log("stopTimer called");
  clearInterval(timerInterval);
  timerInterval = null;
};

function initTimer() {
  const timerEl = document.getElementById("timer");
  const hiddenEl = document.getElementById("study_seconds");
  console.log("initTimer called", timerEl, hiddenEl);
  if (timerEl && hiddenEl) {
    console.log("Calling startTimer...");
    window.startTimer();
  }
}

document.addEventListener("DOMContentLoaded", initTimer);
document.addEventListener("turbo:load", initTimer);
document.addEventListener("turbo:frame-load", initTimer);
