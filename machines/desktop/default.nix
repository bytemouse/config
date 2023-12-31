{ config, pkgs, lib, ... }:
{

  imports = [
    ./hardware.nix
    ../../configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disko-config.nix
  ];

  setup = {
    mail.enable = true;
    gui.desktop.enable = true;
    screen = "big";
    ocr.enable = true;
    extraArch.enable = false;
    libvirt.autostart.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  services = {
    xserver.desktopManager.gnome.enable = true;
  };

  networking = {
    hostName = "desktop";
    networkmanager = {
      enable = true;
    };
  };

}
