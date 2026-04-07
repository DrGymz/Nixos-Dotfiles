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
  configs = {
    nvim = "nvim";
    dwm = "dwm";
  };
in

{
  home.username = "asus";
  home.homeDirectory = "/home/asus";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [ xorg.xsetroot ];

  systemd.user.services.dwm-status = {
    Unit = {
      Description = "dwm status bar clock";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Environment = "DISPLAY=:0";
      ExecStart = "${pkgs.writeShellScript "dwm-status" ''
        while true; do
          ${pkgs.xorg.xsetroot}/bin/xsetroot -name " $(date '+%a %b %d  %H:%M') "
          sleep 30
        done
      ''}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "DrGymz";
      user.email = "258542754+DrGymz@users.noreply.github.com";
    };
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  imports = [
    ./modules/neovim.nix
    ./modules/firefox.nix
  ];
}
