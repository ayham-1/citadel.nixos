{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    citadel.users.steam.enable = lib.mkEnableOption "Citadel: Enables Steam userconfig";
  };

  config = lib.mkIf config.citadel.users.steam.enable {
    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            gamemode
            libxcursor
            libxi
            libxinerama
            libxscrnsaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib # Provides libstdc++.so.6
            libkrb5
            keyutils
            libGL
            libGLU
          ];
      };
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      steam-hardware.enable = true;
    };

    services.xserver.videoDrivers = ["amdgpu" "modesetting"];

    citadel.allowedUnfree = [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "steam-unwrapped"
      "proton-ge-bin"
    ];

    environment.systemPackages = with pkgs; [steam-run mangohud radeontop gamescope protonup-qt];
  };
}
