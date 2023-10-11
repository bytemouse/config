{ unstable, lib, config, pkgs, ... }:
lib.mkIf config.setup.gui.desktop.enable {

  environment.systemPackages = with pkgs; [

    stremio
    pdfarranger
    libreoffice
    xournalpp
    gthumb
    qbittorrent
    torrenttools
    bitwarden
    texlive.combined.scheme-full
    qalculate-gtk
    networkmanagerapplet
    element-desktop
    anki
    pdfgrep
    gimp
    youtube-tui
    meslo-lgs-nf
    fira
    firefox
    calibre
    kdiskmark
    polkit
  ];
  programs.gnome-disks.enable = true;
  services.udisks2.enable = true;
  programs.kdeconnect.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

}
