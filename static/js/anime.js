document.addEventListener("DOMContentLoaded", () => {
  const animeButton = document.getElementById("anime-button");

  if (animeButton) {
    animeButton.addEventListener("click", () => {
      const audio = new Audio("/music/4BGUpWlfFN0.mp3");
      audio.volume = 0.5;
      audio.play().catch((e) => {
        console.error("Audio play failed:", e);
      });

      animeButton.classList.add("fading-out");

      startFallingItems();
    });
  }
});

const madokaStickerPacks = {
  Madoka_Magica: 101,
  HomuraPack: 107,
  nekostickerpack218: 41,
};
const madokaStickerPacksKeys = Object.keys(madokaStickerPacks);
function startFallingItems() {
  const container = document.body;

  setInterval(() => {
    const choice = Math.random();
    let element;

    if (choice < 0.1) {
      element = document.createElement("div");
      element.innerText = "🐈";
    } else if (choice < 0.2) {
      element = document.createElement("div");
      element.innerText = "❄️";
    } else if (choice < 0.3) {
      element = document.createElement("img");
      element.src = "https://mc-heads.net/body/Madoka";
      element.alt = "Madoka";
    } else {
      const randomPackName =
        madokaStickerPacksKeys[
          Math.floor(Math.random() * madokaStickerPacksKeys.length)
        ];
      const randomSticker = (
        Math.floor(Math.random() * (madokaStickerPacks[randomPackName] - 1)) + 1
      )
        .toString()
        .padStart(3, "0");
      element = document.createElement("img");
      element.src = `https://data.chpic.su/stickers/${randomPackName.at(0).toLowerCase()}/${randomPackName}/${randomPackName}_${randomSticker}.webp`;
      element.alt = `Madoka Sticker ${randomPackName} #${randomSticker}`;
    }

    element.className = "falling-thing";

    // Random horizontal start position
    element.style.left = Math.random() * 100 + "vw";

    // Random size
    const size = Math.random() * 30 + 20; // 20px to 50px
    if (element.tagName === "IMG") {
      element.style.height = size * 2 + "px"; // Make images a bit taller
      element.style.width = "auto";
    } else {
      element.style.fontSize = size + "px";
    }

    // Random fall duration
    const duration = Math.random() * 3 + 2; // 2s to 5s
    element.style.animationDuration = duration + "s";

    container.appendChild(element);

    // Remove element after animation completes
    setTimeout(() => {
      if (element.parentNode) {
        element.remove();
      }
    }, duration * 1000);
  }, 300); // Create an item every 300ms
}
