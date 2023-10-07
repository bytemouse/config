{ lib, config, unstable, pkgs, ... }:
lib.mkIf config.setup.gui.enable {

  environment.systemPackages = with pkgs; [

    unzip
    nix-tree
    nix-melt
    nix-diff
    nix-init
    manix
    unstable.diebahn
    nixpkgs-fmt
  ];

}
