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
    nixpkgs.config.allowUnfree = true;
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

      #amdgpu.amdvlk = {
      #    enable = true;
      #    support32Bit.enable = true;
      #};
      steam-hardware.enable = true;
    };

    #hardware.graphics.extraPackages = with pkgs; [
    #  amdvlk
    #];
    #hardware.graphics.extraPackages32 = with pkgs; [
    #  driversi686Linux.amdvlk
    #];

    services.xserver.videoDrivers = ["amdgpu" "modesetting"];

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) ["steam" "steam-original" "steam-run"];

    environment.systemPackages = with pkgs; [steam-run mangohud radeontop gamescope protonup-qt];
  };
}
