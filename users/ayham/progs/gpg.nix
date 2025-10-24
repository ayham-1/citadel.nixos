{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: let
  keyId = "41FE9D7D43999B0A0344E4F4900E1E1A3E142065";
in {
  #programs.ssh.startAgent = true;
  services.pcscd.enable = true;
  home-manager.users.ayham = {pkgs, ...}: {
    programs.gpg = {
      enable = true;
      mutableKeys = true;
    };
    home.packages = with pkgs; [gnupg pinentry-all wayprompt];

    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableSshSupport = true;
      grabKeyboardAndMouse = true;
      pinentryPackage = pkgs.pinentry-curses;
      sshKeys = ["${keyId}"];
    };
  };

  programs.gnupg = {
    agent.enable = true;
    agent.pinentryPackage = pkgs.pinentry-curses;
  };
  environment.systemPackages = with pkgs; [gnupg pinentry-all wayprompt pinentry-curses];
}
