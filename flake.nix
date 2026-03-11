{
  description = "Никс Победа - сайт о победе Nix";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    flake-utils.url = "github:numtide/flake-utils";
    nixtml = {
      url = "github:arnarg/nixtml";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      nixtml,
      ...
    }:
    (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = nixtml.lib.mkWebsite {
          inherit pkgs;
          name = "nix-victory";
          baseURL = "https://никспобеда.рф";

          metadata = {
            lang = "ru";
            title = "НИКС ПОБЕДА";
            description = "Сайт о неизбежной победе Nix";
          };

          content.dir = ./content;
          static.dir = ./static;

          imports = [ ./layouts.nix ];
        };

        apps = {
          serve = {
            type = "app";
            program =
              (pkgs.writeShellScript "serve" ''
                echo "Serving at http://localhost:8080"
                ${pkgs.python3}/bin/python -m http.server -d ${self.packages.${system}.default} 8080
              '').outPath;
          };
          serve-watch = {
            type = "app";
            program =
              (pkgs.writeShellScript "serve-watch" ''
                echo "Watching folder"
                ${pkgs.lib.getExe pkgs.watchexec} --restart --debounce=3000 nix run .#serve
              '').outPath;
          };
          serve-watch-offline = {
            type = "app";
            program =
              (pkgs.writeShellScript "serve-watch-offline" ''
                echo "Watching folder"
                ${pkgs.lib.getExe pkgs.watchexec} --restart --debounce=3000 nix run .#serve --option substitute false
              '').outPath;
          };
        };
      }
    ));
}
