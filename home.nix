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
in

{
  home.username = "asus";
  home.homeDirectory = "/home/asus";
  home.stateVersion = "25.11";

  home.packages = [
    waybar-auto-hide
  ];

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
  ];
}
