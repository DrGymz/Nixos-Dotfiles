{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  stylix.targets.firefox.profileNames = [ "yes" ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.yes = {
      isDefault = true;

      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        sponsorblock
        darkreader
        youtube-shorts-block
      ];

      extraConfig = builtins.readFile ./arkenfox.js;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        "privacy.resistFingerprinting" = false;
        "privacy.resistFingerprinting.letterboxing" = false;

        "network.cookie.lifetimePolicy" = 0;

        # Force dark content + UI to match Stylix chrome (koda)
        "layout.css.prefers-color-scheme.content-override" = 0;
        "ui.systemUsesDarkTheme" = 1;
        "browser.display.background_color" = "#101010";
        "browser.display.foreground_color" = "#b0b0b0";
        "browser.display.use_system_colors" = false;

        # Prevent white flash before page load
        "browser.startup.blankWindow" = false;

        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };
}
