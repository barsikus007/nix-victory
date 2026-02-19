# никспобеда.рф

## шаги к победе

1. `yt-dlp 4BGUpWlfFN0 --format bestaudio --output 4BGUpWlfFN0.webm`
   - `ffmpeg -i 4BGUpWlfFN0.webm -ss 7 -to 310 4BGUpWlfFN0.mp3`
2. `nix run .#serve`
   - `watchexec --restart --debounce=3000 nix run .#serve`
      - `watchexec --restart --debounce=3000 nix run .#serve --option substitute false`
3. `nix build && rsync --verbose --archive --copy-links result/ никспобеда.рф:www/никспобеда.рф/`
