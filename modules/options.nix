{ config, lib, ... }:
{

  options = with lib; with lib.types; {

    setup = {
      
      screen = mkOption { type = enum [ "big" "small" ]; default = "small"; };
      
      mail.enable = mkEnableOption "Mail";
      gui = {
        enable = mkEnableOption "GUI";
        mobile.enable = mkEnableOption "Mobile";
        desktop.enable = mkEnableOption "Mobile";
      };

    };

  };

  config = { 
    
    setup.gui.enable = lib.mkDefault (config.setup.gui.mobile.enable || config.setup.gui.desktop.enable ); 

  };

}
