{ pkgs, config, lib, ... }:
let 
    pgUser = "blocky";
    pgPassword= "blocky";
    pgDb = "blocks";
    pgPort = 15432;
    bPort = config.services.blocky.settings.httpPort;
    # i have to store the password in a file to avoid the following promt (it is not an error - it is just annoying)
    # trace: warning: Declarations in the `secureJsonData`-block of a datasource will be leaked to the
    # Nix store unless a file-provider or an env-var is used!
    passwordFile = builtins.toFile "sqlpassword" ''
        ${pgPassword}
    '';
in
lib.mkIf config.services.blocky.enable {
  
  #FIXME networking.nameservers = [ "127.0.0.1" ];
  services.resolved.enable = false;

  users.users.blocky-postgresql = {
    uid = 950;
    isSystemUser = true;
    home = "/var/lib/blocky-postgresql";
    createHome = true;
    group = "blocky-postgresql";
  };
  
  users.groups.blocky-postgresql = {};

  services.blocky = {
    settings = {
      upstream = {
        default = [
          "https://dns.digitale-gesellschaft.ch/dns-query"
          "https://dns.quad9.net/dns-query"
        ];
      };
      bootstrapDns = { upstream = "tcp+udp:9.9.9.9"; };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
      port = lib.mkDefault 53;
      httpPort = 4000;
      prometheus = {
        enable = true;
        path = "/metrics";
      };
      blocking = {
        blackLists = {
          ads = [
            "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
        };
      };
      queryLog = {
        type = "postgresql"; # if the type is not updated then the blocky.services has to be restarted 
        logRetentionDays = 7;
        target = "postgresql://${pgUser}:${pgPassword}@localhost:15432/${pgDb}";
      };
    };
  };

  virtualisation.oci-containers.containers.postgresqlBlocky = {
    image = "docker.io/library/postgres:15.2-alpine";
    user = "${toString config.users.users.blocky-postgresql.uid}";
    ports = [ "127.0.0.1:${toString pgPort}:5432" ];
    environment = {
        POSTGRES_USER = "${pgUser}";
        POSTGRES_PASSWORD = "${pgPassword}";
        POSTGRES_DB = "${pgDb}";
    };
    volumes = [
      "${config.users.users.blocky-postgresql.home}:/var/lib/postgresql/data"
    ];
    autoStart = true;
  };

  virtualisation.podman.enable = lib.mkForce true;

  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      { job_name = "blocky"; static_configs = [ { targets = [ "127.0.0.1:${toString bPort}" ]; } ]; }
    ];
  };

  services.grafana.provision.datasources.settings.datasources = [ 
    {
      name = "Prometheus";  
      url = "http://127.0.0.1:${toString config.services.prometheus.port}"; 
      type = "prometheus"; 
    } 
    {
      name = "main_server_postgresql_blocky"; 
      url = "127.0.0.1:${toString pgPort}"; 
      type = "postgres";
      user = "blocky";
      secureJsonData.password = "$__file{${passwordFile}}";
      jsonData = { database = "blocks"; sslmode = "disable"; };
    } 
  ];
  services.grafana.provision.dashboards.settings.providers = [
    { 
      name = "Blocky Dashboards"; 
      options.path = "${pkgs.grafanaDashboardsConfig.override ({ 
        host = "${config.networking.hostName}";
        categorie = "blocky";
      })}";
    }
  ];

}
