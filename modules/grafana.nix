{ sops, config, lib, ... }:
let 
  # trace: warning: Grafana passwords will be stored as plaintext in the Nix store!
  # Use file provider or an env-var instead.
  gPass = config.sops.secrets."grafana/admin/password".path;
  grafanaDomain = config.services.grafana.settings.server.domain;
  grafanaPort = config.services.grafana.settings.server.http_port;
in
lib.mkIf config.services.grafana.enable {

  sops.secrets."grafana/admin/password" = {
    owner = config.users.users.grafana.name;
  };

  services.nginx.virtualHosts."${grafanaDomain}" = lib.mkIf config.services.nginx.enable {
    enableACME = true;
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString grafanaPort}";
  };

  services.grafana = {
    settings = {
      server.domain = lib.mkIf config.services.nginx.enable "grafana.pro7on.de";
      security = {
        # if a password was already configured then /var/lib/grafana has to be removed
        admin_password = "$__file{${gPass}}";
      };
    };
  };

  services.grafana.provision.datasources.settings.datasources = lib.mkIf config.services.prometheus.enable [ 
    {
      name = "Prometheus";  
      url = "http://127.0.0.1:${toString config.services.prometheus.port}"; 
      type = "prometheus"; 
    } 
  ];
}
