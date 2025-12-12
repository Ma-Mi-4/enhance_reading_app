console.log("question_quiz.js loaded");

// 正解インデックスは HTML から受け取る
const correctIndexes = JSON.parse(
  document.getElementById("question_form")?.dataset.correct || "[]"
);

function calculateAccuracy() {
  let count = 0;
  const form = document.getElementById("question_form");

  correctIndexes.forEach((correct, i) => {
    const checked = form.querySelector(`input[name="q${i}"]:checked`);
    if (checked && Number(checked.value) === correct) count++;
  });

  const accuracy = Math.round((count / correctIndexes.length) * 100);
  document.getElementById("accuracy_field_questions").value = accuracy;
  console.log("accuracy:", accuracy);
}

const form = document.getElementById("question_form");

if (form) {
  form.addEventListener("submit", () => {
    console.log("form submit → stopTimer & calcAccuracy");
    window.stopTimer();
    calculateAccuracy();
  });
}
