{
  config.website.files = {
    "css/style.css".text = /* css */ ''
      h1, h2, h3, h4, h5, h6, body {
        margin: 0;
      }
      body {
        font-family: system-ui, -apple-system, sans-serif;
        background-color: #1a1b26;
        color: #c0caf5;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        text-align: center;
      }
      img {
        margin: 1vw;
        max-width: 95vw;
      }
      h1 {
        font-size: 4rem;
        color: #7aa2f7;
      }
      a {
        color: #bb9af7;
        text-decoration: none;
        display: inline-block;
      }
      a:hover {
        text-decoration: underline;
      }
      footer {
        background-color: #111111;
      }

      .container {
        flex: 1;
        padding: 20px 10px 10px 10px;
        margin: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        gap: 24px;
      }
      .status {
        font-size: 2rem;
        font-weight: bold;
        color: #9ece6a;
      }
      .reasons {
        list-style: none;
        padding: 0;
        margin: 0;
      }
      .reasons li {
        font-size: 1.2rem;
        margin: 0.5rem 0;
      }

      #victory-counter {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 2rem;
        margin: 2rem 0;
      }
      .counter-item {
        display: flex;
        flex-direction: column;
        align-items: center;
      }
      .number {
        font-size: 3rem;
        font-weight: bold;
        color: #ff9e64;
      }
      .label {
        font-size: 1rem;
        color: #a9b1d6;
        text-transform: uppercase;
      }
      .counter-label {
        width: 100%;
        margin-top: 1rem;
        font-size: 1.2rem;
        color: #7aa2f7;
      }
      #counter-item-years        {width: 3ch;}
      #counter-item-days         {width: 3ch;}
      #counter-item-hours        {width: 2ch;}
      #counter-item-minutes      {width: 2ch;}
      #counter-item-seconds      {width: 2ch;}
      #counter-item-milliseconds {width: 3ch;}

      .yandex-mirror {
        margin-top: 2rem;
        margin-bottom: 1rem;
      }
      .yandex-mirror img {
        opacity: 0.8;
        transition: opacity 0.3s ease;
      }
      .yandex-mirror img:hover {
        opacity: 1;
      }

      .memes {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
      }

      #anime-button {
        position: absolute;
        top: 0;
        right: 0;
        width: 10vw;
        cursor: pointer;
        transition: opacity 2s ease-out;
      }
      .fading-out {
        opacity: 0;
        pointer-events: none;
      }
      @keyframes scroll {
        0% { transform: translateX(0); }
        100% { transform: translateX(calc(-300px * 6 - 2rem * 6)); }
      }
      @keyframes fall {
        0% { top: -50px; transform: rotate(0deg); }
        100% { top: 110vh; transform: rotate(360deg); }
      }
      .falling-thing {
        position: fixed;
        top: -50px;
        z-index: 9999;
        animation: fall 5s linear forwards;
        pointer-events: none;
      }
    '';
    "js/anime.js".text = /* javascript */ ''
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
            element.src = `https://data.chpic.su/stickers/$${randomPackName.at(0).toLowerCase()}/$${randomPackName}/$${randomPackName}_$${randomSticker}.webp`;
            element.alt = `Madoka Sticker $${randomPackName} #$${randomSticker}`;
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
    '';
    "js/counter.js".text = /* javascript */ ''
      document.addEventListener('DOMContentLoaded', () => {
        // https://github.com/NixOS/nix/commit/75d788b0f24e8de033a22c0869032549d602d4f6
        const nixCreationDate = new Date('2003-03-13T14:24:49');

        const counterItemYears = document.getElementById('counter-item-years');
        const counterItemDays = document.getElementById('counter-item-days');
        const counterItemHours = document.getElementById('counter-item-hours');
        const counterItemMinutes = document.getElementById('counter-item-minutes');
        const counterItemSeconds = document.getElementById('counter-item-seconds');
        const counterItemMilliseconds = document.getElementById(
          'counter-item-milliseconds',
        );

        const minuteInMs = 1000 * 60;
        const hourInMs = minuteInMs * 60;
        const dayInMs = hourInMs * 24;

        function updateCounter() {
          const now = new Date();

          let years = now.getFullYear() - nixCreationDate.getFullYear();
          let nixAnniversary = new Date(nixCreationDate.getTime());
          nixAnniversary.setFullYear(now.getFullYear());

          if (now < nixAnniversary) {
            years--;
            nixAnniversary.setFullYear(now.getFullYear() - 1);
          }

          const diff = now - nixAnniversary;

          const days = Math.floor(diff / dayInMs);
          const hours = Math.floor((diff % dayInMs) / hourInMs);
          const minutes = Math.floor((diff % hourInMs) / minuteInMs);
          const seconds = Math.floor((diff % minuteInMs) / 1000);
          const milliseconds = diff % 1000;

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
    '';
  };
}
