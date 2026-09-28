{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  config = lib.mkIf config.citadel.users.${username}.gpg.enable {
    programs.gpg = {
      enable = true;
      mutableKeys = true;

      scdaemonSettings = {
        disable-ccid = true;
        pcsc-shared = true;
      };
    };

    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableSshSupport = true;
      enableExtraSocket = true;
      grabKeyboardAndMouse = true;
      pinentry.package = pkgs.pinentry-curses;
      sshKeys = [config.citadel.users.${username}.gpg.key];
    };

    home.packages = with pkgs; [
      gnupg
      pinentry-curses
      yubikey-manager
    ];
  };
}
