{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  hardware.acpilight.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.asusd.enable = true;
  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];
  services.power-profiles-daemon.enable = false;

  services.xserver.dpi = 192;
}
