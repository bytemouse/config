# NOTE: my first idea doesn't work, because gpg can't find the needed directory
# NOTE: Big Brain Time
#secrets = builtins.fromJSON (builtins.readFile (pkgs.runCommand ''sops'' {
#  file = ./git-secrets.nix;
#} ''
#  ${pkgs.sops}/bin/sops -d $file 
#''));
{ lib, config, pkgs, ... }:
{

  options.secrets = with lib; with lib.types; {

    acme = {
      email = mkOption { type = str; };
    };

    git.email = mkOption {
      type = str;
      default = oneLine ./files/git/email;
    };

    email = {
      mailbox = {
        address = mkOption { type = str; };
        username = mkOption { type = str; };
        realname = mkOption { type = str; };
      };
      tudresden = {
        address = mkOption { type = str; };
        username = mkOption { type = str; };
        realname = mkOption { type = str; };
      };
    };

    calendar.nextcloud = {
      url = mkOption { type = str; };
      user = mkOption { type = str; };
    };

  };

  config.secrets = builtins.fromJSON (builtins.readFile ./../git-secrets.json);

}
