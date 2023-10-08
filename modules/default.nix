{ config, pkgs, lib, ... }:
{
  imports = [

    ./packages

    ./htop.nix
    ./programs.nix
    ./users.nix
    ./audio.nix
    ./agent.nix
    ./virtualisation.nix
    ./environment.nix
    ./shell.nix
    ./options.nix
    ./theme.nix
    ./console.nix
    ./sops.nix
    ./ocr.nix
    ./nnn.nix
    ./gnome.nix
    ./ssh.nix
    ./hostapd.nix
    ./git-secrets.nix
  ];
}
