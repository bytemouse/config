{ config, pkgs, lib, ... }:
{
  users.users.snd = {
    # hashedPassword = "$y$j9T$kHVxr/UFKI.HXCr3wiblL0$.YC6nSzSly5ECiRsa1kCqYMnjADDrowP1yny28kvB7/";
    password = "test";
    isNormalUser = true;
    description = "snd";
    extraGroups = [ "journalctl" "video" "networkmanager" "wheel" ];
  };
  users.users.jan = {
    # hashedPassword = "$y$j9T$kHVxr/UFKI.HXCr3wiblL0$.YC6nSzSly5ECiRsa1kCqYMnjADDrowP1yny28kvB7/";
    password = "test789";
    isNormalUser = true;
    description = "jan";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
