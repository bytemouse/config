# After adding a new key to .sops.yaml dont forget to update:
# sops updatekeys
# https://github.com/Mic92/sops-nix/issues/200
{ lib, config, pkgs, ... }:
let
  aK = config.sops.age.generateKey;
in
{

  sops = {
    defaultSopsFile = ./../secrets.yaml;
    age = {
      sshKeyPaths = [ "/home/snd/secrets" ];
      # NOTE: /var/lib/sops-nix/key.txt will be generated
      # manually creating the file or the content of the file is not necessary
      keyFile = lib.mkIf aK "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

  users.users.snd.packages = with pkgs; [
    sops
    age
  ];

}
