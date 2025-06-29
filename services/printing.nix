{ pkgs, ... }:

{
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  services.printing.drivers = [ pkgs.hplip pkgs.hplipWithPlugin ];

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
