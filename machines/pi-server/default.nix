{ config, pkgs, lib, ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware.nix
    ./disko-config.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
  ];

  networking.hostName = "pi-server";

  setup = {
    screen = "big";

  };

  services = {
    openssh.enable = true;
  };

}
