{
  config,
  pkgs,
  ...
}: {
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;

    packages = with pkgs; [
      fira-mono
      libertine
      open-sans
      twemoji-color-font
      liberation_ttf
      noto-fonts
      noto-fonts-color-emoji
      font-awesome
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      #defaultFonts = {
      #  monospace = [ "Fira Mono" ];
      #  serif = [ "Fira Serif" ];
      #  sansSerif = [ "Fira Sans" ];
      #  emoji = [ "Twitter Color Emoji" ];
      #};
    };
  };
}
