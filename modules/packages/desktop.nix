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
    texlive.combined.scheme-small
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
  ];

}
