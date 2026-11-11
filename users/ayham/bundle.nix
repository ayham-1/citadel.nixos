{...}: {
  imports = [
    ./../common/bundle.nix
  ];

  citadel.users.browsers.librewolf.enable = true;
}
