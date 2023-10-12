{ config, pkgs, lib, ... }:
{

  imports = [
    ./hardware.nix
    ../../configuration.nix
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  setup = {
    mail.enable = true;
    gui.desktop.enable = true;
    screen = "small";
    ocr.enable = true;
    extraArch.enable = false;

  };

  virtualisation.libvirtd.enable = false;

  services = {
    xserver.desktopManager.gnome.enable = true;
  };

  networking = {
    hostName = "thinkpad";
    networkmanager = {
      enable = true;
    };
  };

}
