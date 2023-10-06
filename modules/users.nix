{ config, pkgs, lib, ... }:
{
  users.users.snd = {
    uid = 1000;
    # hashedPassword = "$y$j9T$7BatRoIvM/06kkM1zOs.W1$Phy/NxA2qJFl.j6NygjrNr53KG4oWEPEvqpNfokvS7.";
    password = "test";
    isNormalUser = true;
    description = "bytemouse";
    extraGroups = [ "podman" "journalctl" "docker" "libvirtd" "video" "adbusers" "networkmanager" "wheel" ];
  };
}
