{ config, lib, pkgs, ... }:
let
  desktop = config.setup.gui.desktop.enable;
  sway-desktop = pkgs.makeDesktopItem {
    name = "sway-desktop";
    desktopName = "Sway Desktop";
    exec = "${pkgs.sway}/bin/sway";
  };
in
{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
    meslo-lgs-nf
    fira
    fira-code
  ];

  services.greetd = {
    enable = desktop;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --sessions ${sway-desktop}/share/applications/";
        user = "greeter";
      };
    };
  };

  services.xserver = {
    enable = config.setup.gui.enable;
    layout = config.console.keyMap;
    xkbVariant = "";
    libinput.enable = true;
  };

  programs = {
    java.enable = desktop;
    adb.enable = desktop;
    light.enable = desktop;
  };

  security.pam.services.swaylock = lib.mkIf config.home-manager.users.snd.programs.swaylock.enable {
    text = ''
      auth include login
    '';
  };

}
