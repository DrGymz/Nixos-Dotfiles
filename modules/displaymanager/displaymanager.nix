{ pkgs, ... }:
{
  services.displayManager.ly = {
    enable = true;
    # defaultUser = "asus";
  };
  # programs.silentSDDM = {
  #   enable = true;
  #   theme = "nord";
  #   backgrounds = {
  #     moon = ../../wallpapers/moon-blurred.jpeg;
  #   };
  #   # settings = {
  #   #
  #   # 	}
  # };
}
