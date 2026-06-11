{ lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "hyprlang";

    settings = {
      general = {
        gaps_in = 4;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = lib.mkForce "rgba(808080ee)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 1;
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "b0,0,1,0,1.05"
          "b1,0,1.1,0,1.05"
        ];
        animation = [
          "windows,1,4,b1,slide"
          "windowsIn,1,4,b0,popin 88%"
          "windowsOut,1,4,b0,slide"
          "workspaces,1,3,default,slide"
        ];
      };

      dwindle.preserve_split = true;
      master.new_status = "master";
      misc.force_default_wallpaper = -1;
      xwayland.force_zero_scaling = true;

      monitor = "eDP-1,3840x2400,auto,auto";

      "exec-once" = [
        "waybar"
        "waybar_auto_hide"
        "hyprpaper"
        "hypridle"
        "swaync"
        "asusctl leds set low"
        "wl-paste --type text  --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      input = {
        kb_layout = "us";
        repeat_rate = 35;
        repeat_delay = 200;
        follow_mouse = 1;
        force_no_accel = true;
        sensitivity = 1.0;
        touchpad.natural_scroll = false;
      };

      cursor = {
        inactive_timeout = 30;
        no_hardware_cursors = true;
      };

      gesture = "3, horizontal, workspace";

      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      #"$menu" = "~/.config/rofi/launchers/type-2/launcher.sh";
      "$menu" = "rofi -show drun";

      bind = [
        "SUPER, Return, exec, $terminal"
        "SUPER, B,      exec, firefox"
        "SUPER, Q,      killactive,"
        "SUPER, M,      exit,"
        "SUPER, F,      exec, $fileManager"
        "SUPER, D,      exec, $menu || pkill rofi"
        "SUPER, R,      exec, pkill waybar; waybar & disown; waybar_auto_hide & disown"
        "SUPER, P,      pseudo,"
        "SUPER, V,      exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        ", Print,       exec, grim -g \"$(slurp -d)\" - | tee ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"

        "SUPER, left,  movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up,    movefocus, u"
        "SUPER, down,  movefocus, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        "SUPER,       S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up,   workspace, e-1"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp,   exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ", XF86KbdLightOnOff,     exec, asusctl leds next"
      ];

      bindl = [
        ", XF86AudioNext,  exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay,  exec, playerctl play-pause"
        ", XF86AudioPrev,  exec, playerctl previous"
      ];

      windowrule2 = [
        "suppress_event maximize, class:.*"
        "no_focus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
