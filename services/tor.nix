{
  config,
  pkgs,
  lib,
  ...
}: {
  services.tor = {
    enable = false;
    openFirewall = false;
    client.enable = false;
    relay.enable = false; # no

    torsocks.enable = false;
  };
  #programs.tor-browser.enable = true;

  environment.systemPackages = with pkgs; [
    torsocks
    tor-browser
    onioncircuits
  ];
}
