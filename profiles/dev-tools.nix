{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    libresprite
    vscode
    pureref
    godot
    blender
    blockbench
    pixelorama
  ];
}
