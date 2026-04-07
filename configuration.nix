{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;

  hardware.graphics.enable = true;
  hardware.acpilight.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];

  services = {
    asusd.enable = true;
    supergfxd.enable = true;
    displayManager.ly.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "modesetting" ];
      dpi = 192;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      windowManager = {
        dwm.enable = true;
      };
    };
    openssh.enable = true;
  };

  systemd.services.supergfxd.path = [ pkgs.pciutils ];

  users.users.asus = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "video"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    alacritty
    wget
    fastfetch
    btop
    brightnessctl
  ];

  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
    geist-mono
  ];

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (_: {
        src = ./nixos-config/dwm;
      });
    })
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";

}
