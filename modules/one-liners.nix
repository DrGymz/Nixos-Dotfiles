{ pkgs, ... }:
{
  home.packages = with pkgs; [
    amberol
    bibata-cursors
    bitwarden-desktop
    blueman
    brightnessctl
    claude-code
    cliphist
    curl
    discord
    eza
    feh
    google-chrome
    grim
    hypridle
    hyprpaper
    kitty
    libnotify
    localsend
    maim
    mangohud
    nemo
    networkmanagerapplet
    obsidian
    pavucontrol
    pkg-config
    playerctl
    prismlauncher
    qbittorrent
    qgnomeplatform
    qgnomeplatform-qt6
    screen
    slurp
    swaynotificationcenter
    tree
    vlc
    wl-clipboard
    wlogout
    zoom-us
    zsh-powerlevel10k
  ];

  programs.bash = {
    enable = true;
  };

  programs.btop.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "cd ~/dotfiles && git add . && nix flake update && sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
      #      ls = "eza -l";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "z"
      ];
    };
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      fastfetch
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "DrGymz";
      user.email = "258542754+DrGymz@users.noreply.github.com";
    };
  };

  gtk.enable = true;
  # gtk.gtk4.theme = null;
  qt.enable = true;
}
