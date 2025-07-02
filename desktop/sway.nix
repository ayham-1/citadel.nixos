{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    sway
    swaybg
    swaylock
    swayidle
    kitty
    mako
    grim
    slurp
    wl-clipboard
    kitty
  ];

  services.seatd.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };
}
