{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: let
  keyId = "41FE9D7D43999B0A0344E4F4900E1E1A3E142065";
in {
  services.pcscd.enable = true;
  home-manager.users.ayham = {pkgs, ...}: {
    programs.gpg = {
      enable = true;
      mutableKeys = true;

      scdaemonSettings = {
        disable-ccid = true;
        pcsc-shared = true;
      };
    };
    home.packages = with pkgs; [gnupg pinentry-all];

    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableSshSupport = true;
      enableExtraSocket = true;
      grabKeyboardAndMouse = true;
      pinentryPackage = pkgs.pinentry-curses;
      sshKeys = ["${keyId}"];
    };
  };

  services.udev.packages = with pkgs; [
    yubikey-personalization
    libu2f-host
  ];

  hardware.gpgSmartcards.enable = true;

  programs.gnupg = {
    agent.enable = true;
    agent.pinentryPackage = pkgs.pinentry-curses;
  };
  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-all
    pinentry-curses
    yubikey-manager
  ];
}
