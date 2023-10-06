# After adding a new key to .sops.yaml dont forget to update:
# sops updatekeys
# https://github.com/Mic92/sops-nix/issues/200
{ inputs, lib, nixosConfig, pkgs, ... }:
{

  imports = [ inputs.sops-nix.homeManagerModule ];
  
  sops = {
    defaultSopsFile = ./../../secrets.yaml;
    age = nixosConfig.sops.age; 
  };

}
