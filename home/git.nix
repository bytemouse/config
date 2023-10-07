# NOTE: How to add public key to codeberg,github,... ?
# gpg --armor --export snd-git
{ nixosConfig, config, pkgs, ... }:
let
  guiPackages = with pkgs; if nixosConfig.setup.gui.desktop.enable then [
    gitg # GNOME/GTK GUI client to view git repositories
  ] else [ ];
in
{
  programs.git = {
    enable = true;
    userName = "bytemouse";
    userEmail = "bytemouse@posteo.org";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      commit = {
        gpgsign = true;
      };
      user = {
        signingkey = "75035FA99C09E99336461218A8C13B19E24AF69E";
      };
      pull = {
        rebase = true;
      };
    };
    aliases = {
      undo = "reset HEAD~";
      pub = "push -u origin";
    };
    delta = {
      enable = true;
      options = {
        line-numbers = "true";
        side-by-side = "true";
        features = "decorations";
        syntax-theme = "ansi";
        blame-code-style = "syntax";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
        };
      };
    };
  };

  home.packages = with pkgs; [
    gitui
    lazygit
  ] ++ guiPackages;

}
