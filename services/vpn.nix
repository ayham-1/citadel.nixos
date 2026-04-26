{pkgs, ...}: {
  #  networking.nameservers = [
  #    "1.1.1.1"
  #    "1.0.0.1"
  #  ];
  #
  #  services.resolved = {
  #    enable = true;
  #    dnssec = "true";
  #    domains = ["~."];
  #    fallbackDns = [
  #      "1.1.1.1"
  #      "1.0.0.1"
  #    ];
  #    dnsovertls = "true";
  #  };
  #
  #  services.mullvad-vpn.enable = true;
  #  services.mullvad-vpn.package = pkgs.mullvad-vpn;
}
