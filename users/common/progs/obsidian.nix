{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    citadel.users.obsidian.enable = lib.mkEnableOption "Citadel: Enables Obsidian userconfig";
  };

  config = lib.mkIf config.citadel.users.obsidian.enable {
    environment.systemPackages = with pkgs; [obsidian];

    citadel.allowedUnfree = ["obsidian"];
  };
}
