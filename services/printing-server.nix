{ pkgs, ... }:

{
    # Enable automatic discovery of the printer from other Linux systems with avahi running.
    services.avahi.enable = true;
    services.avahi.publish.enable = true;
    services.avahi.publish.userServices = true;
    services.printing.browsing = true;
    services.printing.listenAddresses = [ "*:631" ]; # Not 100% sure this is needed and you might want to restrict to the local network
    services.printing.allowFrom = [ "all" ]; # this gives access to anyone on the interface you might want to limit it see the official documentation
    services.printing.defaultShared = true; # If you want
}
