{username, ...}: {
  programs.kdeconnect.enable = true;

  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  home-manager.users.${username} = {pkgs, ...}: {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
