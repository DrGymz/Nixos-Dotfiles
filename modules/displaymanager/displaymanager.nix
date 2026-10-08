{ pkgs, ... }:
let
  blackholeDur = pkgs.fetchurl {
    url = "https://codeberg.org/fairyglade/ly-community/raw/commit/2f22cfaf7d17598c8f60f562d56e16d74b6c99ab/animations/dur/blackhole-smooth-240x67.dur";
    hash = "sha256-wo3FzPtngCsg/bRSDTYHQqKnMp4vY+Btm14vakJERBU=";
  };
in
{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "dur_file";
      dur_file_path = "${blackholeDur}";
      full_color = true;
      battery_id = "BAT1";
      # bigclock = "en";
      # bigclock_seconds = true;
      save = true;
    };
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
