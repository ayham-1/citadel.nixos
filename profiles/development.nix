{
  config,
  pkgs,
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
    kicad-small
    kicad
  ];
}
