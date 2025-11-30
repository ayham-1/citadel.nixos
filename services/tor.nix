{
  config,
  pkgs,
  lib,
  ...
}: {
  services.tor = {
    enable = true;
    openFirewall = true;
    client.enable = true;
    relay.enable = false; # no

    torsocks.enable = true;
  };
  #programs.tor-browser.enable = true;

  environment.systemPackages = with pkgs; [
    torsocks
    tor-browser
    onioncircuits
  ];
}
