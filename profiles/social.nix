{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    irssi
    newsboat
    yt-dlp
    telegram-desktop
    signal-desktop
  ];

  # TODO: remove this
  #citadel.allowedUnfree = ["discord" "discord-unwrapped"];
}
