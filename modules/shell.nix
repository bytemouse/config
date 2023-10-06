{ unstable, pkgs, ... }:
{

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    histSize = 10000;
    shellInit = ''
      # starship
      eval "$(starship init zsh)"
    '';
    shellAliases = {
      l = "lsd -l";
      la = "lsd -la";
      ls = "lsd";
      lt = "tree";
      c = "clear";
      eza = "${unstable.eza}/bin/eza -abghHilS";
      f = "${pkgs.fzf}/bin/fzf";
      bt = "${pkgs.bottom}/bin/btm";
    };
  };

  programs.starship = {
    enable = true;
    settings.add_newline = false;
  };

  environment.systemPackages = with pkgs; [
    lsd
    tree
    starship
    bat
    tldr
    gping
  ];

  environment.variables = {
    FZF_DEFAULT_OPTS = ''
      --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
      --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
      --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
    '';
  };

}
