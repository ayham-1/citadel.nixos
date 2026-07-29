{
  config,
  lib,
  pkgs,
  ...
}: let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in {
  programs.sway = {enable = true;};
  environment.systemPackages = with pkgs; [
    sway
    swaybg
    swaylock
    swayidle
    wl-kbptr
    kitty
    mako
    grim
    slurp
    wl-clipboard
    kitty
    wdisplays
    qt5.qtwayland
    swappy
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    waybar
    dmenu
    wmenu
    kanshi
    flameshot
  ];

  services.seatd.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  };
  environment.etc."greetd/environments".text = ''
    sway
    zsh
  '';

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    #QT_QPA_PLATFORM = "xcb";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };
}
