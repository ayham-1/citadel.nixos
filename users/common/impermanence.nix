{
  impermanence,
  home-manager,
  username,
  ...
}: {
  imports = [
    impermanence.nixosModules.impermanence
    home-manager.nixosModules.home-manager
  ];

  home-manager.users.${username} = {
    home.persistence."/persistent" = {
      directories = [
        "desk"
        "pix"
        "dox"
        "muz"
        ".config/kdeconnect/"
        ".cache/dl/"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        {
          directory = ".config/Yubico";
          mode = "0700";
        }
        ".local/share/direnv"
        ".factorio"
        ".steam"
      ];
    };
  };
}
