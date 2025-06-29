{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ gcc gnumake clang gdb ];
}
