{ pkgs, ... }:
let
  #You can write scripts inside nix files, everyday the more you know!
  asusStatus = pkgs.writeShellScript "asus-perf-status" ''
    mode=$(asusctl profile get | awk '/Active profile/ {print $NF}')
    case "$mode" in
      Quiet)       echo "Quiet" ;;
      Balanced)    echo "Balanced" ;;
      Performance) echo "Performance" ;;
      *)           echo "broken" ;;
    esac
  '';
  asusToggle = pkgs.writeShellScript "asus-profile-toggle" ''
    asusctl profile next
  '';
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [
      {
        height = 30;
        spacing = 4;
        on-sigusr1 = "hide";
        on-sigusr2 = "show";
        modules-left = [
          "custom/nixicon"
          "clock"
          "hyprland/workspaces"
        ];
        modules-center = [ "tray" ];
        modules-right = [
          "custom/asus"
          "pulseaudio"
          "network"
          "battery"
          "custom/notification"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
          persistent-workspaces = {
            "*" = 4;
          };
        };

        "hyprland/window" = {
          max-length = 40;
          seperate-outputs = false;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            phone-muted = "󰏳";
            portable = "󰦾";
            car = "󰄋";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          scroll-step = 1;
          on-click = "blueman-manager";
          ignored-sinks = [ "Easy Effects Sink" ];
        };

        "custom/asus" = {
          exec = "${asusStatus}";
          interval = 2;
          on-click = "${asusToggle}";
          tooltip = false;
        };

        clock = {
          timezone = "America/Chicago";
          format = "{:%I:%M %p}";
          tooltip-format = "{:%m-%d-%Y}";
        };

        "custom/notification" = {
          tooltip = true;
          format = "<span size='16pt'>{icon}</span>";
          format-icons = {
            notification = "󱅫";
            none = "󰂜";
            dnd-notification = "󰂠";
            dnd-none = "󰪓";
            inhibited-notification = "󰂛";
            inhibited-none = "󰪑";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        battery = {
          interval = 2;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-full = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰚥  {capacity}%";
          format-icons = [
            "󰁺"
            "󰁾"
            "󰂀"
            "󰁹"
          ];
          tooltip-format = "{}";
        };

        network = {
          interval = 5;
          on-click = "airctl";
          format-wifi = "󰤨  {essid}";
          format-disconnected = "󰤭  Disconnected";
          tooltip = false;
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };

        "custom/nixicon" = {
          format = "";
          tooltip = false;
          on-click = "~/.config/rofi/launchers/type-2/launcher.sh";
        };
      }
    ];

    style = ''
      @define-color bg0 @base01;
      @define-color bg1 @base00;
      @define-color bg2 @base02;
      @define-color bg3 @base03;

      @define-color deepblue @base0D;
      @define-color slate    @base04;
      @define-color moon     @base05;
      @define-color crimson  @base08;
      @define-color amber    @base0A;
      @define-color green    @base0B;
      @define-color cyan     @base0C;

      @define-color fg @base05;

      * {
          border: none;
          border-radius: 0px;

          font-family: "Adwaita Sans", "JetBrainsMono Nerd Font Propo", "GeistMono Nerd Font", sans-serif;
          font-weight: bold;

          min-height: 0;
          padding: 0;
          margin: 0;
      }

      window#waybar {
          background: transparent;
      }

      tooltip {
          background: @bg0;
          border: 1px solid @bg3;
          border-radius: 12px;
      }

      tooltip label {
          color: @fg;
          padding: 6px;
      }

      #workspaces {
          background-color: @bg0;
          padding: 5px 3px;
          margin: 4px 0 0 12px;
          border-radius: 18px;
          border: 1px solid @bg0;
          color: @fg;
      }

      #workspaces button {
          padding: 0px 6px;
          margin: 0px 8px;
          border-radius: 50px;
          color: transparent;
          background-color: @bg1;
          transition: all 0.3s ease-in-out;
      }

      #workspaces button:not(.empty) {
          background-color: alpha(@bg3, 0.35);
          color: alpha(@fg, 0.35);
          min-width: 25px;
          transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
          background-color: @bg3;
          color: @fg;
          min-width: 50px;
          transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
          background-color: @bg3;
          color: @fg;
          border-radius: 16px;
          min-width: 50px;
      }

      #workspaces button.urgent {
          background-color: @bg0;
          color: @bg0;
          border-radius: 16px;
          min-width: 50px;
          transition: all 0.3s ease-in-out;
      }

      #battery,
      #pulseaudio,
      #network,
      #clock,
      #custom-nixicon,
      #custom-notification,
      #custom-asus {
          background-color: @bg0;
          padding: 0 15px;
          margin: 4px 0 0 12px;
          border-radius: 50px;
          border: 1px solid @bg1;
      }

      #clock               { color: @moon; }
      #custom-notification { color: @slate; margin: 4px 12px 0 10px; }
      #pulseaudio          { color: @slate; }
      #network             { color: @slate; }
      #custom-nixicon     { color: @cyan; }
      #battery             { color: @green; }
      #battery.warning     { color: @amber; }
      #battery.critical    { color: @crimson; }
      #custom-asus         { color: @slate; }
    '';
  };

  stylix.targets.waybar = {
    addCss = false;
    font = "sansSerif";
  };
}
