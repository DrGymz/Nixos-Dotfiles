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
    chromium
    curl
    discord
    eza
    feh
    grim
    hypridle
    hyprpaper
    kitty
    libnotify
    localsend
    ly
    maim
    mangohud
    nemo
    networkmanagerapplet
    pavucontrol
    pkg-config
    playerctl
    python3
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
    zsh-completions
  ];

  gtk.enable = true;
  qt.enable = true;
}
