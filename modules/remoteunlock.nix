{ lib, config, ... }:
let 
  ip = config.setup.remoteunlock.ip;
  interface = config.setup.remoteunlock.interface;
  subnet = config.setup.remoteunlock.subnet;
in
{

  options.setup.remoteunlock = with lib; with lib.types; {
    enable = mkEnableOption "Unlock encrypted disk(s) remotely";
    ip = mkOption { type = str; default = "10.0.0.1"; };
    subnet = mkOption { type = str; default = "255.255.255.0"; };
    interface = mkOption { type = str; default = "lan0"; };
  };

  config = lib.mkIf config.setup.remoteunlock.enable {

    # unlock encrypted disk remotely
    boot.initrd = {
      network.enable = true;
      network.ssh = {
        enable = true;
        port = 22;
        shell = "/bin/cryptsetup-askpass";
        # NOTE: The build will fail if not every host key exists
        # however there is no nice way to create the key file with e.g. environment.etc
        # at least i wasn't able to find one
        # therefore the key has to be generated before the rebuild
        # sudo ssh-keygen -t ed25519 -N "" -f /etc/ssh_initrd_host_ed25519_key
        hostKeys = [
          "/etc/ssh_initrd_host_ed25519_key"
        ];
        authorizedKeys = config.users.users.snd.openssh.authorizedKeys.keys;
        ignoreEmptyHostKeys = true;
      };
    };
    
    boot.kernelParams = [
      # Important: the client needs a static ip as well
      # e.g. i added an NetworkManger profile with static ip 10.0.0.10 and gateway 10.0.0.1 that i activate when needed
      "ip=${ip}::${ip}:${subnet}:${config.networking.hostName}:${interface}:off" 
    ];
  };

}
