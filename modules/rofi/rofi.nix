{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  # stylix.targets.rofi.alternatePattern = false;

  programs.rofi = {
    enable = true;

    settings = {
      modi = "drun,run,filebrowser,window";
      show-icons = true;
      icon-theme = "Papirus";
      drun-display-format = "{name}";
      cycle = true;
      normalize-match = true;
      click-to-exit = true;
    };

    theme = {
      "*" = {
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      window = {
        width = mkLiteral "35%";
        border-radius = mkLiteral "12px";
        padding = mkLiteral "8px";
      };

      mainbox.children = map mkLiteral [
        "inputbar"
        "listview"
      ];

      inputbar = {
        children = map mkLiteral [
          "prompt"
          "entry"
        ];
        background-color = mkLiteral "@lightbg";
        border-radius = mkLiteral "8px";
        padding = mkLiteral "10px 12px";
        spacing = mkLiteral "8px";
      };

      entry.placeholder = "Search";

      listview = {
        lines = 8;
        column = 2;
        fixed-height = false;
        scrollbar = false;
        padding = mkLiteral "8px 0px 0px 0px";
        spacing = mkLiteral "4px";
      };

      element = {
        border-radius = mkLiteral "8px";
        padding = mkLiteral "8px 10px";
        spacing = mkLiteral "10px";
      };

      element-icon.size = mkLiteral "22px";
    };
  };
}
