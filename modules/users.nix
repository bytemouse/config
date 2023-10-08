{ config, pkgs, lib, ... }:
{
  users.users.snd = {
    uid = 1000;
    hashedPassword = "$y$j9T$bpxx.DAJ/JLjS6do18TQk1$sKUPds2dp51xyxsRt42JAHge1k2SGoJq5ddIuTzV5b1";
    isNormalUser = true;
    description = "bytemouse";
    extraGroups = [ "podman" "journalctl" "docker" "libvirtd" "video" "adbusers" "networkmanager" "wheel" ];
  };
}
