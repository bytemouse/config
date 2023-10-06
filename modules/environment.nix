{ config, lib, pkgs, ... }:
let 
  qt = config.home-manager.users.snd.qt.enable;
  gtk = config.home-manager.users.snd.gtk;
in
{
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = lib.mkIf qt "gtk2";
    GTK_THEME = lib.mkIf gtk.enable gtk.theme.name; 
  };
}
