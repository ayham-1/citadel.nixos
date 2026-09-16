{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  options = {
    citadel.users.${username}.gpg = {
      enable = lib.mkEnableOption "user: enable gpg";
      key = lib.mkOption {};
    };
  };

  config = lib.mkIf config.citadel.users.${username}.gpg.enable {
    services.pcscd.enable = true;
    home-manager.users.${username} = {pkgs, ...}: {
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
        pinentry.package = pkgs.pinentry-curses;
        sshKeys = [config.citadel.users.${username}.gpg.key];
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
  };
}
