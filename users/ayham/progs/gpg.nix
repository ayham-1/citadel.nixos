{ config, pkgs, lib, home-manager, ... }: {
  programs.ssh.startAgent = false;
  home-manager.users.ayham = { pkgs, ... }: {
    programs.gpg = {
      enable = true;
      mutableKeys = true;
    };

    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableSshSupport = true;
      grabKeyboardAndMouse = true;
      pinentryPackage = pkgs.gtk2;
      sshKeys = [ "41FE9D7D43999B0A0344E4F4900E1E1A3E142065" ];
    };

    home.sessionVariables = {
      SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
      GPG_TTY = "$(tty)";
    };

    home.activation = {
      initGPG = ''
        gpgconf --kill gpg-agent
        gpg-connect-agent updatestartuptty /bye >/dev/null
      '';
    };
  };
}
