{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  home.username = "asus";
  home.homeDirectory = "/home/asus";
  home.stateVersion = "25.11";

  imports = [
    ./modules/neovim/neovim.nix
    ./modules/firefox/firefox.nix
    ./modules/one-liners/one-liners.nix
    ./modules/kitty/kitty.nix
    ./modules/swaync/swaync.nix
    ./modules/hyprlock/hyprlock.nix
    ./modules/hyprland/hyprland.nix
    ./modules/hypridle/hypridle.nix
    ./modules/rofi/rofi.nix
    ./modules/waybar/waybar.nix
    ./modules/obsidian/obsidian.nix
    ./modules/terminal/terminal.nix
  ];
}
