{pkgs, ...}: {
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
    godot
    blender
    blockbench
    pixelorama
  ];

  programs.nvf = {
    enable = true;
    settings = import ./../services/nvf.nix;
    enableManpages = true;
  };
}
