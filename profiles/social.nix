{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    irssi
    discord
    newsboat
    yt-dlp
    ferdium
    telegram-desktop
    signal-desktop
  ];

  # TODO: remove this
  citadel.allowedUnfree = ["discord" "discord-unwrapped"];
}
