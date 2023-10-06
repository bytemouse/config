{ config, pkgs, lib, ... }:
{

  imports = [
    ./hardware.nix
    ../../configuration.nix
  ];

  setup = {
    mail.enable = true;
    gui.desktop.enable = true;
    screen = "small";
    ocr.enable = true;

  };


  virtualisation.libvirtd.enable = true;

  services = {
    xserver.desktopManager.gnome.enable = true;
  };

  networking = {
    hostName = "thinkpad";
    nameservers = [ "127.0.0.1" ];
    networkmanager = {
      enable = true;
    };
  };

}
