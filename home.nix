{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/nixos-config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  waybar-auto-hide = pkgs.rustPlatform.buildRustPackage {
    pname = "waybar-auto-hide";
    version = "0.1.0";
    src = inputs.waybar-auto-hide;
    cargoHash = "sha256-mUY36hnyU/qjHRLqRwfVLl6hAGIy92Sg6s1XB56Hvf8=";
  };
  configs = {
    nvim = "nvim";
    rofi = "rofi";
    kitty = "kitty";
    tmux = "tmux";
    waybar = "waybar";
    swaync = "swaync";
    hypr = "hypr";
  };
in

{
  home.username = "asus";
  home.homeDirectory = "/home/asus";
  home.stateVersion = "25.11";

  home.packages = [
    waybar-auto-hide
    (inputs.apple-fonts.packages.${pkgs.system}.sf-pro.overrideAttrs (_: {
      src = pkgs.fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
        hash = "sha256-W0sZkipBtrduInk0oocbFAXX1qy0Z+yk2xUyFfDWx4s=";
      };
    }))
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    font = {
      name = "JetBrainsMono Nerd Font Propo";
      size = 11;
    };
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  imports = [
    ./modules/neovim.nix
    ./modules/firefox.nix
    ./modules/one-liners.nix
  ];
}
