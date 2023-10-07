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
        "postep" = {
          primary = true;
          address = "${nixosConfig.secrets.email.mailbox.address}";
          userName = "${nixosConfig.secrets.email.mailbox.username}";
          realName = "${nixosConfig.secrets.email.mailbox.realname}";
          imap = {
            host = "imap.mailbox.org";
            tls.useStartTls = true;
          };
          smtp = {
            host = "smtp.mailbox.org";
            port = 587;
            tls.useStartTls = true;
          };
          thunderbird = {
            enable = true;
            profiles = [ "personal" ];
          };
        };
        "tu-dresden" = {
          primary = false;
          address = "${nixosConfig.secrets.email.tudresden.address}";
          userName = "${nixosConfig.secrets.email.tudresden.username}";
          realName = "${nixosConfig.secrets.email.tudresden.realname}";
          imap = {
            host = "msx.tu-dresden.de";
            tls.useStartTls = true;
          };
          smtp = {
            host = "msx.tu-dresden.de";
            port = 587;
            tls.useStartTls = true;
          };
          thunderbird = {
            enable = true;
            profiles = [ "personal" ];
          };
        };
      };
    };
  };
}
