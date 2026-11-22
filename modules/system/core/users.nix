{...}: {
  flake.citadel.modules.core.users = {...}: {
    users = {
      # centrally manage users
      mutableUsers = false;

      # disable the root account
      users = {
        root = {
          hashedPassword = "!";
        };
      };
    };
  };
}
