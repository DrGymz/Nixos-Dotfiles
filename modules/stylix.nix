{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    image = ../wallpapers/moon.jpg;

    base16Scheme = {
      base00 = "101010";
      base01 = "272727";
      base02 = "474747";
      base03 = "50585d";
      base04 = "777777";
      base05 = "b0b0b0";
      base06 = "d6d6d6";
      base07 = "ffffff";
      base08 = "ff7676";
      base09 = "ff5733";
      base0A = "d9ba73";
      base0B = "86cd82";
      base0C = "5abfb5";
      base0D = "458ee6";
      base0E = "f2a4db";
      base0F = "701516";
    };

    opacity.terminal = 0.80;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.geist-mono;
        name = "GeistMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Sans";
      };
      serif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Sans";
      };
      sizes = {
        desktop = 11;
        terminal = 14;
      };
    };
  };
}
