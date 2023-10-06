{ lib, nixosConfig, ... }:
lib.mkIf nixosConfig.setup.gui.desktop.enable {

  services.easyeffects.enable = true;
  # TODO: Once I have the profiles finished,
  # add them here

}
