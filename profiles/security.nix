{ config, pkgs, lib, aa-alias-manager, ... }: {
  imports = [ aa-alias-manager.nixosModules.default ];

  environment.memoryAllocator.provider = "libc";

  # Setup firewall
  networking.firewall.enable = true;
  networking.firewall.allowPing = false;

  # Apparmor
  security.apparmor.enable = true;
  security.apparmor.packages = with pkgs; [ apparmor-profiles roddhjav-apparmor-rules ];
  security.apparmor.aa-alias-manager.enable = true;
  services.dbus.apparmor = "enabled";

  # General Hardening
  security.forcePageTableIsolation = true;
  security.sudo.enable = true;
  security.audit.enable = true;
  security.auditd.enable = true;
  security.rtkit.enable = true;
  security.chromiumSuidSandbox.enable = true;
  security.polkit.enable = true;
  security.lockKernelModules = true;

  # Isolate
  security.isolate.enable = true;

  # Kernel Hardening
  boot.kernelPackages = pkgs.linuxPackages_hardened;
  security.protectKernelImage = true;
  boot.kernelParams = [
    "slub_debug=FZP"
    "page_poison=1"
    "page_alloc.shuffle=1"
    "lsm=lockdown,yama,apparmor,bpf"
  ];
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "kernel.yama.ptrace_scope" = 1;
    "kernel.lockdown" = 1;
  };

  # Sandboxing
  programs.firejail.enable = true;
}
