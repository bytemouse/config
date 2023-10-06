{ config, lib, pkgs, ... }:
let
  sdl = config.setup.spotdl;
  nSN = config.setup.protection.nameSpaceName;
in
{
  options = with lib; with lib.types; {
    setup.spotdl = {
      enable = mkEnableOption "SpotDL";
      downloadDirectory = mkOption { type = str; };
      userName = mkOption { type = str; }; 
    };
  };

  config = lib.mkIf config.setup.spotdl.enable {

    setup.protection.enable = true;

    sops.secrets."spotdl" = {
      owner = config.systemd.services.spotdl.serviceConfig.User;
    };

    systemd.timers.spotdl = {
      wantedBy = [ "timers.target" ];
      after = [ "wireguard-wg-protection.service" ];
      requires = [ "wireguard-wg-protection.service" ];
      description = "Sync my Spotify Playlists to the local device";
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec  = "30m";
        Unit = "spotdl.service";
      };
    };

    systemd.services."spotdl" = {
      serviceConfig = {
        PrivateNetwork = true;
        NetworkNamespacePath = "/run/netns/${nSN}";
        # systemd-analyze --no-pager security spotdl.service
        CapabilityBoundingSet = null;
        PrivateDevices = true;
        PrivateTmp = true;
        PrivateUsers = true;
        #ProtectHome = true;
        RestrictNamespaces = true;
        SystemCallFilter = "@system-service";

        Type = "oneshot";
        User = sdl.userName;
        Group = config.users.users."${sdl.userName}".group;
        BindReadOnlyPaths = [
          "/var/empty:/run/nscd"
          "/etc/netns/${nSN}/resolv.conf:/etc/resolv.conf"
        ];
      };
      script = ''
        cd ${sdl.downloadDirectory}
        ${pkgs.spotdl}/bin/spotdl "$(${pkgs.coreutils}/bin/echo -n $(${pkgs.coreutils}/bin/cat ${config.sops.secrets."spotdl".path}))" --save-file liked-songs.spotdl --m3u liked-songs --audio youtube-music
      '';
    };

  };

}
