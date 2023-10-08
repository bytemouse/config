{ config, pkgs, lib, ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
  ];

  disko.devices = pkgs.callPackage ./disko-config.nix {
    disks = [ "/dev/<disk-name>" ]; # replace this with your disk name i.e. /dev/nvme0n1
  };

  networking.hostName = "pi-server";

  setup = {
    screen = "big";

  };

  services = {
    openssh.enable = true;
  };

}
