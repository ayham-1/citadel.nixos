{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    citadel.obsidian.enable = lib.mkEnableOption "Citadel: Enable Obsidian";
  };

  config = lib.mkIf config.citadel.obsidian.enable {
    environment.systemPackages = with pkgs; [obsidian];

    citadel.allowedUnfree = ["obsidian"];
  };
}
