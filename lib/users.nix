{
  home-manager,
  niri,
}: {
  mkUsers = usernames:
    builtins.concatMap (username: [
      ./../users/common/user-settings.nix
      ./../users/${username}/bundle.nix
      {
        _module.args.username = username;
      }
    ])
    usernames;
}
