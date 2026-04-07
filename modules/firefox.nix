{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  programs.firefox = {
    enable = true;

    profiles.yes = {
      isDefault = true;

      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        sponsorblock
        darkreader
        youtube-shorts-block
      ];

      # Arkenfox (Read from a local file)
      extraConfig = builtins.readFile ./arkenfox.js;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        "privacy.resistFingerprinting" = false;
        "privacy.resistFingerprinting.letterboxing" = false;

        "network.cookie.lifetimePolicy" = 0;
      };

      userChrome = ''
        /* Gruvbox Dark Color Palette */
        :root {
          --toolbar-bgcolor: #282828 !important;
          --toolbar-color: #ebdbb2 !important;
          --toolbar-field-background-color: #3c3836 !important;
          --toolbar-field-color: #ebdbb2 !important;
          --tab-selected-bgcolor: #504945 !important;
          --tab-selected-textcolor: #fbf1c7 !important;
        }

        /* Main backgrounds (Navbar, Sidebar, Toolbox) */
        #navigator-toolbox, #sidebar-box, #nav-bar {
          background-color: var(--toolbar-bgcolor) !important;
          color: var(--toolbar-color) !important;
          border: none !important;
        }

        /* URL Search Bar */
        #urlbar-background, #searchbar {
          background-color: var(--toolbar-field-background-color) !important;
          border: 1px solid #504945 !important;
        }
        #urlbar-input {
          color: var(--toolbar-field-color) !important;
        }

        /* Active Tab Styling */
        .tab-background[selected="true"] {
          background-color: var(--tab-selected-bgcolor) !important;
          background-image: none !important;
        }
        .tabbrowser-tab[selected="true"] .tab-text {
          color: var(--tab-selected-textcolor) !important;
        }

        /* Hide the line between tabs and navbar */
        #navigator-toolbox::after { border-bottom-color: transparent !important; }
      '';

      # 5. Gruvbox Theme (New Tab / Blank Pages)
      userContent = ''
        @-moz-document url("about:newtab"), url("about:blank"), url("about:home") {
          body {
            background-color: #282828 !important;
            color: #ebdbb2 !important;
          }
        }
      '';
    };
  };
}
