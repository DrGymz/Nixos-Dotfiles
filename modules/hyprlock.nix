{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
      };

      background = {
        blur_passes = 2;
        blur_size = 8;
      };

      input-field = {
        monitor = "";
        size = "250, 55";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.3;
        rounding = 12;
        placeholder_text = "<i>Password...</i>";
        fade_on_empty = false;
        position = "0, -120";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 90;
          font_family = "GeistMono Nerd Font";
          color = "rgb(b0b0b0)";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %d %B"'';
          font_size = 22;
          font_family = "GeistMono Nerd Font";
          color = "rgb(777777)";
          position = "0, 10";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
