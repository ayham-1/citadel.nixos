{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    irssi
    discord
    newsboat
    yt-dlp
    spotify
    ferdium
  ];
}
