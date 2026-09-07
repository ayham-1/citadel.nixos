{
  impermanence,
  home-manager,
  ...
}: {
  imports = [
    impermanence.nixosModules.impermanence
    home-manager.nixosModules.home-manager
  ];

  home-manager.users.ayham = {
    home.persistence."/persistent" = {
      directories = [
        "desk"
        "pix"
        "dox"
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
