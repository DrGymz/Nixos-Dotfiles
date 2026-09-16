{ config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  cc = config.lib.stylix.colors;
  rgb = b: "${toString cc."${b}-rgb-r"}, ${toString cc."${b}-rgb-g"}, ${toString cc."${b}-rgb-b"}";
  font = config.stylix.fonts.sansSerif.name;
  fontSize = toString config.stylix.fonts.sizes.desktop;
in
{
  stylix.targets.swaync.enable = false;

  services.swaync = {
    enable = true;

    style = ''
      :root {
        --cc-bg: rgba(${rgb "base00"}, 0.9);
        --noti-border-color: ${c.base03};
        --noti-bg: ${rgb "base01"};
        --noti-bg-alpha: 1;
        --noti-bg-darker: ${c.base00};
        --noti-bg-hover: ${c.base02};
        --noti-bg-focus: ${c.base02};
        --noti-close-bg: ${c.base02};
        --noti-close-bg-hover: ${c.base03};
        --text-color: ${c.base05};
        --text-color-disabled: ${c.base04};
        --bg-selected: ${c.base03};
      }

      * {
        font-family: "${font}";
        font-size: ${fontSize}pt;
        outline: none;
        box-shadow: none;
      }

      .summary, .time {
        color: ${c.base06};
      }

      .notification {
        min-height: 60px;
      }

      .notification-group,
      .notification-group:focus,
      .notification-group:hover {
        background: transparent;
      }

      .widget-dnd > switch:checked {
        background-color: ${c.base04};
      }

      .control-center {
        border: 1px solid ${c.base03};
      }

      .widget-mpris .widget-mpris-player {
        border: 1px solid ${c.base03};
      }

      .widget-mpris .widget-mpris-player .mpris-overlay {
        background-color: ${c.base01};
      }

      scrollbar {
        opacity: 0;
        min-width: 0;
        min-height: 0;
      }

      .control-center-list-placeholder image {
        opacity: 0;
      }
    '';

    settings = {
      positionX = "right";
      positionY = "top";
      cssPriority = "user";
      control-center-width = 380;
      control-center-height = 860;
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;
      notification-window-width = 400;
      notification-icon-size = 48;
      notification-body-image-height = 160;
      notification-body-image-width = 200;
      timeout = 4;
      timeout-low = 2;
      timeout-critical = 6;
      fit-to-screen = false;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = false;
      script-fail-notify = true;
      scripts = { };
      notification-visibility = { };
      widgets = [
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = " 󰎟 ";
        };
        dnd = {
          text = "Do not disturb";
        };
        label = {
          max-lines = 1;
          text = " ";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
        volume = {
          label = "󰕾";
          show-per-app = true;
        };
        buttons-grid = {
          actions = [
            {
              label = "";
              command = "amixer set Master toggle";
            }
            {
              label = "";
              command = "amixer set Capture toggle";
            }
            {
              label = "";
              command = "airctl";
            }
            {
              label = "󰤨";
              command = "nm-connection-editor";
            }
            {
              label = "󰂯";
              command = "blueman-manager";
            }
          ];
        };
      };
    };
  };
}
