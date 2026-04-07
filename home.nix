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

  home.packages = with pkgs; [ xsetroot ];

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 64;
    x11.enable = true;
  };

  systemd.user.services.wallpaper-cycle = {
    Unit = {
      Description = "Cycle wallpapers from ~/dotfiles/wallpapers";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Environment = "DISPLAY=:0";
      ExecStart = "${pkgs.writeShellScript "wallpaper-cycle" ''
        while true; do
          for img in ${config.home.homeDirectory}/dotfiles/wallpapers/*; do
            ${pkgs.feh}/bin/feh --bg-fill "$img"
            ${pkgs.coreutils}/bin/sleep 300
          done
        done
      ''}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

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
          BAT_CAP=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | ${pkgs.coreutils}/bin/head -1 || echo "?")
          BAT_STATUS=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/BAT*/status 2>/dev/null | ${pkgs.coreutils}/bin/head -1 || echo "")
          if [ "$BAT_STATUS" = "Charging" ]; then
            BAT_ICON="⚡"
          else
            BAT_ICON="🔋"
          fi
          ${pkgs.xorg.xsetroot}/bin/xsetroot -name " $BAT_ICON $BAT_CAP%   $(${pkgs.coreutils}/bin/date '+%a %b %d  %I:%M %p') "
          ${pkgs.coreutils}/bin/sleep 30
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
