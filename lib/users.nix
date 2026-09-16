{
  home-manager,
  niri,
}: {
  mkUsers = usernames:
    builtins.concatMap (username: [
      ./../users/${username}/config.nix
      {
        _module.args.username = username;
      }
    ])
    usernames;
}
