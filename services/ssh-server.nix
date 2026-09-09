{
  config,
  lib,
  ...
}: {
  imports = [./ssh.nix];

  options = {
    citadel.ssh.server.enable = lib.mkEnableOption "Citadel: SSH server";
    citadel.ssh.server.enableYubikeyAccess = lib.mkEnableOption "Citadel: SSH for users to allow for yubikey";
  };

  config = lib.mkIf config.citadel.ssh.server.enable {
    services.openssh = {
      enable = true;
      settings.LogLevel = "VERBOSE";
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      settings.PermitRootLogin = "no";
      settings.X11Forwarding = true;
    };
  };
}
