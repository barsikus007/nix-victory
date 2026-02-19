document.addEventListener("DOMContentLoaded", () => {
  // https://github.com/NixOS/nix/commit/75d788b0f24e8de033a22c0869032549d602d4f6
  const startDate = new Date("2003-03-13T14:24:49");

  const counterItemYears = document.getElementById("counter-item-years");
  const counterItemDays = document.getElementById("counter-item-days");
  const counterItemHours = document.getElementById("counter-item-hours");
  const counterItemMinutes = document.getElementById("counter-item-minutes");
  const counterItemSeconds = document.getElementById("counter-item-seconds");
  const counterItemMilliseconds = document.getElementById(
    "counter-item-milliseconds",
  );

  const minuteInMs = 1000 * 60;
  const hourInMs = minuteInMs * 60;
  const dayInMs = hourInMs * 24;
  const yearInMs = dayInMs * 365;

  function updateCounter() {
    const now = new Date();
    const diff = now - startDate;

    const years = Math.floor(diff / yearInMs);
    const days = Math.floor((diff % yearInMs) / dayInMs);
    const hours = Math.floor((diff % dayInMs) / hourInMs);
    const minutes = Math.floor((diff % hourInMs) / minuteInMs);
    const seconds = Math.floor((diff % minuteInMs) / 1000);
    const milliseconds = Math.floor(diff % 1000);

    if (!counterItemYears) return;
    counterItemYears.innerText = years;
    counterItemDays.innerText = days;
    counterItemHours.innerText = hours;
    counterItemMinutes.innerText = minutes;
    counterItemSeconds.innerText = seconds;
    counterItemMilliseconds.innerText = milliseconds;
  }

  setInterval(updateCounter, 1);
  updateCounter();
});
