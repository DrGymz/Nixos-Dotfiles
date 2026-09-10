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
in

{
  home.username = "asus";
  home.homeDirectory = "/home/asus";
  home.stateVersion = "25.11";

  xdg.configFile = {
    "nvim/lua".source = create_symlink "${dotfiles}/nvim/lua";
  };

  imports = [
    ./modules/neovim.nix
    ./modules/firefox.nix
    ./modules/one-liners.nix
    ./modules/kitty.nix
    ./modules/swaync.nix
    ./modules/hyprlock.nix
    ./modules/hyprland.nix
    ./modules/hypridle.nix
    ./modules/rofi.nix
    ./modules/waybar.nix
    ./modules/obsidian.nix
    # ./modules/displaymanager.nix
  ];
}
