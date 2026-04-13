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
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;
  hardware.acpilight.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];

  services = {
    asusd.enable = true;
    supergfxd.enable = true;
    displayManager.ly.enable = true;
    libinput = {
      enable = true;
      mouse = {
        accelSpeed = "1.0";
        accelProfile = "flat";
      };
    };
    xserver = {
      enable = true;
      videoDrivers = [ "modesetting" ];
      dpi = 192;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
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
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    fastfetch
  ];

  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
    geist-mono
  ];

  # Particle Photon 2 / P2 USB access (DFU + CDC modes)
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2b04", MODE="0666", GROUP="dialout"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="2b04", MODE="0666", GROUP="dialout"
  '';

  programs.dconf.enable = true;
  programs.hyprland.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";

}
