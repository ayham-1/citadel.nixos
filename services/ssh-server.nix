{ config, pkgs, lib, ... }: {
  imports = [ ./ssh.nix ];
  services.openssh = {
    enable = true;
    loglevel = "VERBOSE";
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
    X11Forwarding = true;
    ClientAliveInterval = 300;
    ClientAliveCountMax = 16;
    PermitEmptyPasswords = false;
    UseDNS = false;
  };
}
