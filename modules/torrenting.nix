{ sops, config, lib, pkgs, ... }:
let
  cfg = config.setup.qbittorrent;
  nSN = config.setup.protection.nameSpaceName;
in
{
  options.setup.qbittorrent = {
    enable = lib.mkEnableOption "the qbittorrent service";
    homeDir = lib.mkOption { type = lib.types.path; default = "/var/lib/qbittorrent"; };
    configDir = lib.mkOption { type = lib.types.path; default = "${cfg.homeDir}/config"; };
    downloadDir = lib.mkOption { type = lib.types.path; default = "${cfg.homeDir}/download"; };
    webuiPort = lib.mkOption { type = lib.types.int; default = 8099; };
    fqdn = lib.mkOption { type = lib.types.str; default = "torrent.pro7on.de"; };
  };

  config = lib.mkIf config.setup.qbittorrent.enable {

    setup.protection.enable = true;

    users.users.snd.extraGroups = [ "qbittorrent" ];
    
    users.users.qbittorrent = {
      group = "qbittorrent";
      home = cfg.homeDir;
      isSystemUser = true;
    };
    users.groups.qbittorrent = { };

    systemd.tmpfiles.rules = [
      "d '${cfg.downloadDir}' 0775 qbittorrent users - -"
      "d '${cfg.homeDir}' 0771 qbittorrent qbittorrent - -"
    ];

    systemd.services.qbittorrent = {
    
      description = "qBittorrent Service";
      after = [ "wireguard-wg-protection.service" ];
      requires = [ "wireguard-wg-protection.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        
        PrivateNetwork = true;
        NetworkNamespacePath = "/run/netns/${nSN}";

        Restart = "always";
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --profile=${cfg.configDir} --webui-port=${toString cfg.webuiPort}";
        User = "qbittorrent";
        Group = "qbittorrent";

        # Increase number of open file descriptors (default: 1024)
        LimitNOFILE = 65536;

        # systemd-analyze --no-pager security qbittorrent.service
        CapabilityBoundingSet = null;
        PrivateDevices = true;
        PrivateTmp = true;
        PrivateUsers = true;
        ProtectHome = true;
        RestrictNamespaces = true;
        SystemCallFilter = "@system-service";
        # these binds are necessary, because systemd services don't mount /etc/resolv.conf by default
        BindReadOnlyPaths = [
          "/var/empty:/run/nscd"
          "/etc/netns/${nSN}/resolv.conf:/etc/resolv.conf"
        ];
      
      };

    };

    systemd.services.qbittorrent-webui-proxy = {
      
      wantedBy = [ "multi-user.target" ];
      after = [ "wireguard-wg-protection.service" ];
      partOf = [ "wireguard-wg-protection.service" ];

      serviceConfig = {
      
        PrivateNetwork = true;
        NetworkNamespacePath = "/run/netns/${nSN}";

        Restart = "always";
        ExecStart = "${pkgs.socat}/bin/socat UNIX-LISTEN:${cfg.homeDir}/webui.sock,fork,reuseaddr,mode=660,unlink-early TCP:127.0.0.1:${toString cfg.webuiPort}";
        User = "qbittorrent";
        Group = "nginx";

        # systemd-analyze --no-pager security qbittorrent-webui-proxy.service
        CapabilityBoundingSet = null;
        PrivateDevices = true;
        PrivateTmp = true;
        PrivateUsers = true;
        ProtectHome = true;
        RestrictNamespaces = true;
        SystemCallFilter = "@system-service";
        BindReadOnlyPaths = [
          "/var/empty:/run/nscd"
          "/etc/netns/${nSN}/resolv.conf:/etc/resolv.conf"
        ];

      };
    
    };

    systemd.services.qbittorrent_exporter = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      environment = {
        QBITTORRENT_API_SOCKET = "${cfg.homeDir}/webui.sock";
        QBITTORRENT_EXPORTER_LISTEN_ADDRESS = ":9561";
      };
      serviceConfig = {
        ExecStart = "${pkgs.qbittorrent_exporter}/bin/qbittorrent_exporter";
        Restart = "always";
        User = "qbittorrent";
        Group = "qbittorrent";

        # systemd-analyze --no-pager security qbittorrent_exporter.service
        CapabilityBoundingSet = null;
        PrivateDevices = true;
        PrivateUsers = true;
        ProtectHome = true;
        RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
        RestrictNamespaces = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = "@system-service";
      };
    };

    services.nginx.virtualHosts."${cfg.fqdn}" = {
      enableACME = lib.mkDefault true;
      forceSSL = lib.mkDefault true;
      # treated as state
      basicAuthFile = "${cfg.homeDir}/htpasswd";
      locations = {
        "/" = {
          proxyPass = "http://unix:${cfg.homeDir}/webui.sock";
          proxyWebsockets = true;
        };
        "/download/" = {
          alias = "${cfg.downloadDir}/";
          extraConfig = ''
            autoindex on;
          '';
        };
      };
    };

    services.prometheus = {
      scrapeConfigs = [
        { 
          job_name = "qbittorrent"; 
          static_configs = [ { targets = [ "127.0.0.1:9561" ]; } ];
        }
      ];
    };

    services.grafana.provision.dashboards.settings.providers = [
      { 
        name = "qbittorrent"; 
        options.path = "${pkgs.grafanaDashboardsConfig.override ({ 
          host = "${config.networking.hostName}";
          categorie = "qbittorrent";
        })}";
      }
    ];

  };

}

