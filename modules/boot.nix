{ config, pkgs, lib, ... }:
{

  boot = {

    loader = {
      systemd-boot = {
        enable = lib.mkDefault true;

      };
      efi = {
        canTouchEfiVariables = true;
      };
    };


  };

}
