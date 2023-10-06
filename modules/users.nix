{ config, pkgs, lib, ... }:
{
  users.users.snd = {
    # hashedPassword = "$y$j9T$kHVxr/UFKI.HXCr3wiblL0$.YC6nSzSly5ECiRsa1kCqYMnjADDrowP1yny28kvB7/";
    password = "test";
    isNormalUser = true;
    description = "snd";
    extraGroups = [ "podman" "journalctl" "docker" "libvirtd" "video" "adbusers" "networkmanager" "wheel" ];
  };
}
