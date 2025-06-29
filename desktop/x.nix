{ config, pkgs, lib, ... }: {
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;
    #displayManager.emptty.enable = true;
    #displayManager.emptty.pam = true;

    layout = "us,de";
    xkbOptions = "grp:win_space_toggle,caps:escape";
    autoRepeatDelay = 300;
    autoRepeatInterval = 50;

    excludePackages = with pkgs; [ xterm ];

    libinput = {
      enable = true;

      mouse = { accelProfile = "flat"; };

      touchpad = { accelProfile = "flat"; };
    };
  };

  services.xserver.videoDrivers = [ "intel" ];

  environment.systemPackages = with pkgs; [ alacritty xclip ];
}
