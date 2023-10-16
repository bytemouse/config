{ nixosConfig, config, lib, ... }:

lib.mkIf nixosConfig.setup.mail.enable {

  programs.thunderbird = {
    enable = true;
    settings = {
      "privacy.donottrackheader.enabled" = true;
    };
    profiles = {
      personal = {
        isDefault = true;
        settings = {
          "mail.spellcheck.inline" = false;
          "javascript.enabled" = false;
        };
      };
    };
  };

  accounts = {
    email = {
      maildirBasePath = "/home/snd/mail";
      accounts = {
        "posteo" = {
          primary = true;
          address = "${nixosConfig.secrets.email.posteo.address}";
          userName = "${nixosConfig.secrets.email.posteo.username}";
          realName = "${nixosConfig.secrets.email.posteo.realname}";
          imap = {
            host = "posteo.de";
            tls.useStartTls = true;
          };
          smtp = {
            host = "posteo.de";
            port = 587;
            tls.useStartTls = true;
          };
          thunderbird = {
            enable = true;
            profiles = [ "personal" ];
          };
        };
        # "rwth" = {
        #   primary = false;
        #   address = "${nixosConfig.secrets.email.rwth.address}";
        #   userName = "${nixosConfig.secrets.email.rwth.username}";
        #   realName = "${nixosConfig.secrets.email.rwth.realname}";
        #   imap = {
        #     host = "mail.rwth-aachen.de";
        #     tls.useStartTls = true;
        #   };
        #   smtp = {
        #     host = "mail.rwth-aachen.de";
        #     port = 587;
        #     tls.useStartTls = true;
        #   };
        #   thunderbird = {
        #     enable = true;
        #     profiles = [ "personal" ];
        #   };
        # };
      };
    };
  };
}
