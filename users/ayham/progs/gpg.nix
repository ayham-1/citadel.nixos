{ config, pkgs, lib, ... }: {
  imports = [ <home-manager/nixos> ];

  programs.ssh.startAgent = false; # gpg-agent for ssh
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
      pinentryFlavor = "gtk2";
      sshKeys = [ "41FE9D7D43999B0A0344E4F4900E1E1A3E142065" ];
    };
  };
}
