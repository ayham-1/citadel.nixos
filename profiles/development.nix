{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [gcc gnumake cmake clang gdb stm32flash stm32loader stm32cubemx zig git-lfs];
}
