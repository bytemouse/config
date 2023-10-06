{ lib, pkgs, config, ... }:
lib.mkIf config.services.gnunet.enable {
  
  users.users.snd.packages = with pkgs; [ gnunet-gtk ];

}
