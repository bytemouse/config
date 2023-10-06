# credits for changing the gdm theme:
# https://discourse.nixos.org/t/gdm-background-image-and-theme/12632/2
# https://github.com/catppuccin/gtk/issues/21
# https://github.com/braheezy/catppuccin-gtk-rpm
{ unstable, pkgs, lib, config, ... }:
let
  qt = config.home-manager.users.snd.qt.enable;
  gtn = config.home-manager.users.snd.gtk.theme.name;
  gtp = config.home-manager.users.snd.gtk.theme.package;
  gnome-script = pkgs.writeShellScriptBin "gnome-script" ''
    export XDG_SESSION_TYPE=wayland 
    ${pkgs.dbus}/bin/dbus-run-session ${pkgs.gnome.gnome-session}/bin/gnome-session
  '';
  gnome-desktop = pkgs.makeDesktopItem {
    name = "gnome-desktop";
    desktopName = "Gnome Desktop";
    exec = "${gnome-script}/bin/gnome-script";
    terminal = true;
  };
  sway-desktop = pkgs.makeDesktopItem {
    name = "sway-desktop";
    desktopName = "Sway Desktop";
    exec = "${pkgs.sway}/bin/sway";
  };
in
{
  config = lib.mkIf config.services.xserver.desktopManager.gnome.enable {

    # https://github.com/swaywm/sway/issues/5732#issuecomment-1626901938
    xdg.portal.enable = lib.mkForce false;

    # enabling pulseaudio replacment with pipewire works though
    hardware.pulseaudio.enable = false;

    services.xserver.enable = true;

    services.xserver.displayManager.gdm.enable = lib.mkIf config.services.greetd.enable false; # gdm is a pain in the ass to configure

    services.greetd.settings.default_session.command = lib.mkIf config.services.greetd.enable (
      lib.mkForce "${pkgs.greetd.tuigreet}/bin/tuigreet --sessions ${sway-desktop}/share/applications/:${gnome-desktop}/share/applications/"
    );

    environment.systemPackages = [
      gtp
    ];

    # this has to be set, because gnome creates its own conflict, at least for me 
    environment.variables.QT_QPA_PLATFORMTHEME = lib.mkIf qt (lib.mkForce "gtk2");
    environment.sessionVariables.QT_QPA_PLATFORMTHEME = lib.mkIf qt (lib.mkForce "gtk2");

    # unwanted applications
    services.gnome.core-utilities.enable = lib.mkForce false; # removes all the gnome applications
    documentation.nixos.enable = false; # removes the nixos manual
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      mpv-unwrapped # includes mpv and umpv
      gnome.dconf-editor
    ];
    services.xserver.excludePackages = [
      pkgs.xterm
    ];

    users.users.snd.packages = with pkgs; [
      gnome.gnome-terminal # wezterm doesn't work well with gnome
      gnome.nautilus # file manager
      unstable.celluloid # a gtk frontend for mpv
    ];

  };

}
