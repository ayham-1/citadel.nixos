{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    clang
    clang-tools
    gdb
    stm32flash
    stm32loader
    stm32cubemx
    zig
    git-lfs
    gcc-arm-embedded
    kicad
    godot
    savvycan
    qucs-s
    drawio
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "drawio"
    ];
}
