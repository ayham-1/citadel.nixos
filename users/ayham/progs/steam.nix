{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers

    package = pkgs.steam.override {
      extraPkgs = (pkgs: with pkgs; [ 
        gamemode 
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib # Provides libstdc++.so.6
        libkrb5
        keyutils
        libGL
      ]);
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
    pulseaudio.support32Bit = true;
  };

  #24.11 
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  # For 32 bit applications 
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  services.xserver.videoDrivers = [ "amdgpu" "modesetting" ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-original" "steam-run" ];

  environment.systemPackages = with pkgs; [ steam-run mangohud radeontop gamescope steamPackages.steam-fhsenv ];
}
