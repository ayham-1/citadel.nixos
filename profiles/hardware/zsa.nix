{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    citadel.hardware.zsa.enable = lib.mkEnableOption "Citadel: Enable zsa keyboard hardware";
  };

  config = lib.mkIf config.citadel.hardware.zsa.enable {
    hardware.keyboard.zsa.enable = true;
    environment.systemPackages = with pkgs; [
      wally-cli
      keymapp
    ];

    citadel.allowedUnfree = [
      "keymapp"
    ];
  };
}
