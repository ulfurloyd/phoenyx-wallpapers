{
  description = "my wallpaper collection";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
      {
        packages = forAllSystems (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
            {
              default = pkgs.stdenvNoCC.mkDerivation {
                pname = "phoenyx-wallpapers";
                version = "1.0";
                src = ./wallpapers;

                dontUnpack = true;

                installPhase = ''
                    mkdir -p "$out/share/wallpapers"
                    cp -r "$src"/. "$out/share/wallpapers/"
                  '';
                };
            });

        homeManagerModules.default = import ./modules/home-manager.nix;
      };
}
