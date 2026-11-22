{...}: {
  flake.citadel.modules.audio = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      playerctl
      pavucontrol
      pulseaudioFull
      pipewire
      pipewire.jack
      pulsemixer
      qpwgraph
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
