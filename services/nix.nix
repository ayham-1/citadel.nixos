{config, ...}: {
  nix = {
    settings.sandbox = true;
    settings = {
      trusted-users = ["cremator"];
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
