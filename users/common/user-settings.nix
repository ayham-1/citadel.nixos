{
  lib,
  username,
  ...
}: {
  options = {
    citadel.users.${username} = {
      git = {
        enable = lib.mkEnableOption "user: enable git";
        key = lib.mkOption {};
        name = lib.mkOption {};
        email = lib.mkOption {};
      };

      gpg = {
        enable = lib.mkEnableOption "user: enable gpg";
        key = lib.mkOption {};
      };

      obsidian.enable = lib.mkEnableOption "Citadel: Enables Obsidian userconfig";
    };
  };
}
