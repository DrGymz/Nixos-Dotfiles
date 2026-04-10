{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    tmux
    waybar
    swaynotificationcenter
    rofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "git add ~/dotfiles && sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "git add ~/dotfiles && sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
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
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "DrGymz";
      user.email = "258542754+DrGymz@users.noreply.github.com";
    };
  };
}
