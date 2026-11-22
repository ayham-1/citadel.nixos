{self, ...}: {
  flake.citadel.modules.boot = {lib, ...}: let
    modules = with self.citadel.modules.boot.disks; [
      uefi-encrypted
    ];
  in {
    imports = modules;

    boot = {
      loader = {
        timeout = lib.mkDefault 0;
      };

      plymouth = {
        enable = true;
        theme = "tribar";
      };

      # Enable "Silent boot"
      consoleLogLevel = 3;
      kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
      ];
    };
  };
}
