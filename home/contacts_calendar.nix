{ lib, nixosConfig, ... }:
lib.mkIf nixosConfig.setup.gui.desktop.enable {

  accounts.calendar = {
    "personal" = {
      primary = true;
      remote = {
        type = "caldav";
        url = "${nixosConfig.secrets.caldav.personal.url}";
        userName = "${nixosConfig.secrets.caldav.personal.user}";
        passwordCommand = [ "echo" "'${nixosConfig.secrets.caldav.personal.password}'" ];
      };
      khal.enable = true;
    };
  };

  accounts.contact = {
    accounts."personal" = {
      primary = true;
      remote = {
        type = "carddav";
        url = "${nixosConfig.secrets.caldav.personal.url}";
        userName = "${nixosConfig.secrets.caldav.personal.user}";
        passwordCommand = [ "echo" "'${nixosConfig.secrets.caldav.personal.password}'" ];
      };
      khal.enable = true;
    };
  };

}
