# NOTE: wait-online needs at least one interface that is not "no-carrier"
{ config, lib, ... }:
{

  options.setup.bridge = with lib; with lib.types; {
    enable = mkEnableOption "Bridge";
    interfaces = lib.mkOption { type = listOf str; default = []; };
  };

  config = lib.mkIf config.setup.bridge.enable {

  networking.useDHCP = false; # required or every interfaces requestes an ip resulting in no network access
  systemd.network.enable = true;
  networking.networkmanager.enable = false;

    systemd.network = {
      
      netdevs = {
        "40-br0" = { # 40 because the br0 has to be created and configured after every interface that will be assinged to it
          netdevConfig = {
            Name = "br0";
            Kind = "bridge";
          };
        };
      };

      networks = { 
        "40-br0" = { # 40 - see above 
          name = "br0";
          networkConfig.DHCP = "ipv4";
        }; 
      } // ( lib.listToAttrs (
        map (
          iface: lib.nameValuePair "30-${iface}" { bridge = [ "br0" ]; name = iface; }
        ) config.setup.bridge.interfaces
      ));

    };

  };

}
