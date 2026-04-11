# никспобеда.рф

## шаги к победе

1. `yt-dlp 4BGUpWlfFN0 --format bestaudio --output 4BGUpWlfFN0.webm`
   - `ffmpeg -i 4BGUpWlfFN0.webm -ss 7 -to 310 4BGUpWlfFN0.mp3`
2. `nix run .#serve`
   - `nix run .#serve-watch`
   - `nix run .#serve-watch-offline`
3. `nix build && rsync --verbose --archive --copy-links result/ никспобеда.рф:www/никспобеда.рф/`

### как приготовить пирог

```shell
cd static/images

nix build 'github:NixOS/branding#legacyPackages.x86_64-linux.nixos-branding.artifacts.internal.nixos-logomark-default-gradient-none'
cp ./result/* ./
rm result

wget https://raw.githubusercontent.com/NixOS/branding/4872f76c52f6c5aec7c234a6ff7dedfbfd0b4fad/package-sets/top-level/nixos-branding/nixos-branding-guide/images/cake.svg
sed -i \
  -e 's|<path fill="#FBB5A0" d="M0 0h1024v1024H0z"/>||' \
  -e 's|d="M0 0h1024v1024H0z|d="|' \
  cake.svg
```
