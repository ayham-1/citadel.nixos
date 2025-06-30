{ config, pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;

    packages = with pkgs; [
      fira-mono
      libertine
      open-sans
      twemoji-color-font
      liberation_ttf
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Fira Mono" ];
        serif = [ "Fira Serif" ];
        sansSerif = [ "Fira Sans" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
