{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    cargo
    clang-tools
    cmake
    fd
    fzf
    gcc
    jdk
    jdt-language-server
    lua-language-server
    nil
    nixfmt
    nodejs
    pyright
    raylib
    ripgrep
    rust-analyzer
    rustc
    xclip
  ];
  stylix.targets.neovim.enable = false;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
    initLua = builtins.readFile ../nixos-config/nvim/init.lua;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-treesitter
      nvim-ufo

      lualine-nvim
      koda-nvim
      gruvbox-nvim
      tokyonight-nvim
      catppuccin-nvim
      comment-nvim
      nvim-web-devicons

      nvim-cmp
      cmp-nvim-lsp
      neodev-nvim
      nvim-lspconfig
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip

      nvim-colorizer-lua
      mini-pairs
      indent-blankline-nvim

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
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
