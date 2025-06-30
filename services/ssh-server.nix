{ config, pkgs, lib, ... }: {
  imports = [ ./ssh.nix ];
  services.openssh = {
    enable = true;
    settings.LogLevel = "VERBOSE";
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
    settings.X11Forwarding = true;
  };
}
