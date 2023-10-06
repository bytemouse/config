{ nixosConfig, pkgs, lib, ...}:

{
  programs.zathura = {
    enable = nixosConfig.setup.gui.desktop.enable;
    extraConfig = ''
      set guioptions none
      set selection-clipboard clipboard
    '';
  };

}
