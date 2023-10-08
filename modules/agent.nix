{ pkgs, config, lib, ... }:
let
  ge = config.setup.gui.enable;
in
{
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = if ge == true then "gnome3" else "tty";
  };

  programs.ssh.startAgent = true;
  programs.ssh.extraConfig = "AddKeysToAgent yes";

  users.users.snd.packages = lib.mkIf ge (with pkgs; [
    gnome.seahorse
  ]);

}
