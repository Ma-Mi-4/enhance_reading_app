let seconds = 0;
let timerInterval;

function startTimer() {
  clearInterval(timerInterval);
  seconds = 0;
  timerInterval = setInterval(() => {
    seconds++;
    const timerEl = document.getElementById("timer");
    if (timerEl) timerEl.innerText = formatTime(seconds);

    const hiddenEl = document.getElementById("study_seconds");
    if (hiddenEl) hiddenEl.value = seconds;
  }, 1000);
}

function stopTimer() {
  clearInterval(timerInterval);
}

function formatTime(sec) {
  const m = String(Math.floor(sec / 60)).padStart(2,'0');
  const s = String(sec % 60).padStart(2,'0');
  return `${m}:${s}`;
}

window.startTimer = startTimer; // グローバルに露出
window.stopTimer = stopTimer;

document.addEventListener("turbo:load", startTimer);
document.addEventListener("turbo:render", startTimer);
document.addEventListener("DOMContentLoaded", startTimer);
document.addEventListener("turbo:before-cache", stopTimer);
