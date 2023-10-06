{ pkgs, nixosConfig, ... }:

{
  qt = {
    enable = nixosConfig.setup.gui.enable;
    platformTheme = "gtk";
  };

}
