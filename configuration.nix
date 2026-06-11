{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/stylix.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 0;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  time.timeZone = "America/Chicago";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
    persistent = true;
  };
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  #DON'T FORGET TO REMOVE LATER
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  hardware = {
    graphics.enable = true;
    acpilight.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        amdgpuBusId = "PCI:101:0:0";
        nvidiaBusId = "PCI:100:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];

  services = {
    asusd.enable = true;
    supergfxd.enable = true;
    blueman.enable = true;
    libinput = {
      enable = true;
      mouse = {
        accelSpeed = "1.0";
        accelProfile = "flat";
      };
    };
    xserver = {
      enable = false;
      videoDrivers = [ "nvidia" ];
    };
    openssh.enable = true;
    power-profiles-daemon.enable = false;
    displayManager.sddm.wayland.compositor = "kwin";
    displayManager.sddm.settings.Theme = {
      CursorTheme = config.stylix.cursor.name;
      CursorSize = config.stylix.cursor.size;
    };
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
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
    config.stylix.cursor.package
  ];

  fonts.packages =
    (with pkgs.nerd-fonts; [
      jetbrains-mono
      geist-mono
    ])
    ++ [
      pkgs.adwaita-fonts
    ];
  programs = {
    dconf.enable = true;
    hyprland = {
      enable = true;
      withUWSM = false;
    };
    silentSDDM = {
      enable = true;
      theme = "default";
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";
}
