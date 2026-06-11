{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150; # 2.5min — dim backlight (avoid 0 on OLED)
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 150; # 2.5min — kbd backlight off
          on-timeout = "asusctl leds set off";
          on-resume = "asusctl leds set low";
        }
        {
          timeout = 300; # 5min — lock
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330; # 5.5min — screen off
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
          timeout = 1800; # 30min — suspend
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
