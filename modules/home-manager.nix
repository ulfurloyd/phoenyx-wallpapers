{ config, lib, ... }:
let
  cfg = config.services.phoenyx-wallpapers;
in
{
  options.services.phoenyx-wallpapers = {
    enable = lib.mkEnableOption "Phoenyx wallpaper collection";

    directory = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/Wallpapers";
      description = "Directory in which to expose the wallpapers";
    };

    package = lib.mkOption {
      type = lib.types.package;
      description = "Wallpaper collection package";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file."${lib.removePrefix "${config.home.homeDirectory}/" cfg.directory}".source =
      "${cfg.package}/share/wallpapers";
  };
}
