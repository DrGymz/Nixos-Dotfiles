{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # arecord
    cargo
    clang-tools
    cmake
    fd
    fzf
    gcc
    jdk
    jdt-language-server
    lua-language-server
    markdown-oxide
    nil
    nixfmt
    pyright
    ruff
    raylib
    ripgrep
    rust-analyzer
    rustc
    vscode-langservers-extracted
    xclip
  ];
  stylix.targets.neovim.enable = false;

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/neovim/nvim";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = true;
    sideloadInitLua = true;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      bufferline-nvim
      nvim-treesitter
      nvim-ufo
      lualine-nvim
      koda-nvim
      comment-nvim
      nvim-web-devicons
      obsidian-nvim
      nvim-cmp
      cmp-nvim-lsp
      nvim-lspconfig
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      nvim-colorizer-lua
      mini-pairs

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-json
        p.tree-sitter-lua
        p.tree-sitter-bash
        p.tree-sitter-python
        p.tree-sitter-c
        p.tree-sitter-cpp
        p.tree-sitter-css
        p.tree-sitter-java
        p.tree-sitter-rust
      ]))
    ];
  };
}
