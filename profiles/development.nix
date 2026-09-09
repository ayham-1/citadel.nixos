{
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
    zig
    git-lfs
    gcc-arm-embedded
    kicad
    godot
    qucs-s
    drawio
    libresprite
    vscode
    pureref
    godot
    blender
    blockbench
    pixelorama
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "drawio"
      "vscode"
    ];

  #services.udev.packages = [
  #  pkgs.stlink
  #];

  #services.udev.extraRules = ''
  #  SUBSYSTEM=="usb", MODE="0666"
  #'';
}
