{ lib, config, pkgs, ... }:
let
  interface = config.setup.hostapd.interface;
in
{
  options.setup.hostapd = with lib; with lib.types; {
    enable = mkEnableOption "Hostapd";
    interface = mkOption { type = str; default = "wlan0"; };
  };

  config = lib.mkIf config.setup.hostapd.enable {
    
    sops.secrets."hostapd" = {};

    # Wireless
    # Credits: Simon
	  boot.kernelModules = [ "nl80211" ];
	
	  environment.systemPackages = with pkgs; [
	    iw
	    wirelesstools
	  ];

    systemd.services.hostapd = {
	    path = with pkgs; [ hostapd ];
	    after = [ "sys-subsystem-net-devices-${interface}.device" ];
	    bindsTo = [ "sys-subsystem-net-devices-${interface}.device" ];
	    requiredBy = [ "network-link-${interface}.service" ];
	    wantedBy = [ "multi-user.target" ];
	    serviceConfig = {
	      ExecStart = "${pkgs.hostapd}/bin/hostapd ${config.sops.secrets."hostapd".path}";
	      Restart = "always";
	    };
    };

  };

}
