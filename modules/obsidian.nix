{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
    vaults.notes.target = "School";
    defaultSettings = {
      app = {
        alwaysUpdateLinks = true;
        spellcheck = true;
        # vimMode = true;
      };
      communityPlugins = with pkgs.obsidianPlugins; [
        code-styler
        vim-yank-highlight
        calendar
        file-explorer-note-count
        iconic
        obsidian-media-db-plugin
      ];
      themes = with pkgs.obsidianThemes; [
        void
      ];
    };
  };
  home.file = {
    "School/.obsidian/app.json".force = true;
    "School/.obsidian/appearance.json".force = true;
    "School/.obsidian/community-plugins.json".force = true;
  };

  # stylix.targets.obsidian = {
  #   enable = true;
  # };
}
