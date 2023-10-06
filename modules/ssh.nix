{ config, lib, ... }:
{
  config = lib.mkIf config.services.openssh.enable {

    users.users.snd.openssh.authorizedKeys.keys = [

      # Thinkpad
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN5ZJjODHA2rHAU9eocqZBEbfg7ihFA6irtDFXb+OCdK snd@thinkpad"



    ];

    services.openssh.settings.PasswordAuthentication = false;

  };

}
