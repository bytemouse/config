{ nixosConfig, config, pkgs, ... }:

let 
  nnn-nvim = pkgs.fetchFromGitHub {
    owner = "luukvbaal";
    repo = "nnn.nvim";
    rev = "4616ec65eb0370af548e356c3ec542c1b167b415";
    sha256 = "sha256-iJTN1g5uoS6yj0CZ6Q5wsCAVYVim5zl4ObwVyLtJkQ0=";
  };
in
  
{
  
  home.file."init.lua".target = ".config/nvim/lua/init.lua";
  home.file."init.lua".source = ./init.lua;
  
  programs.neovim = {
   
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
   
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      nnn-nvim
      nvim-colorizer-lua
      which-key-nvim
      barbar-nvim
      nvim-web-devicons
      telescope-nvim
      vim-illuminate
      luasnip
      lualine-nvim
      lualine-lsp-progress
      telescope-ui-select-nvim
      nvim-treesitter
      indent-blankline-nvim
      aerial-nvim

      # required for lsp
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp_luasnip
      lspkind-nvim
      rust-vim
      vim-nix
      nvim-lspconfig
      cmp-nvim-lsp
      trouble-nvim
      nvim-treesitter # also required for dap

      # required for noice
      noice-nvim
      nui-nvim
      nvim-notify
      ## a nerd font + nvim-treesitter
    ];

    extraPackages = with pkgs; [
       rust-analyzer rustc  
      gopls
      clang-tools ccls 
      sumneko-lua-language-server
      python310Packages.python-lsp-server
      jdt-language-server
      # the version of ghc can't be newer than the latest supported verson of the haskell-language-server
      # if mutliple versions of ghc are installed the hls configuraton needes to be adjusted
      haskell-language-server ghc stack haskellPackages.cabal-install
      rnix-lsp

      tmux # required for nnn
      pkg-config # required for rust-lsp - for whatever reason
    ];
   
    extraLuaConfig = ''
      require('init')
    '';
  };
}
