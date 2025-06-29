{ config, ... }: {
  nix = {
    settings.sandbox = true;
    settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
