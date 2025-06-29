{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    irssi
    discord
    newsboat
    youtube-dl
    yt-dlp
    spotify
    ferdium
  ];
}
