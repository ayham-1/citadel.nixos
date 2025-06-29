{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libresprite
    vscode
    pureref
    godot
    jetbrains.idea-ultimate
    blender
    lmms
    blockbench-electron
    pixelorama
  ];
}
