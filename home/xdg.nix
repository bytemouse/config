{ lib, config, ...}:
let 
  browser = "librewolf.desktop";
  torrent = "qbittorrent.desktop";
  image = "org.gnome.gThumb.desktop";
  video = "mpv.desktop";
  text = "nvim.desktop";
  pdf = "org.pwmt.zathura.desktop";
in
{
  xdg.mime.enable = true;
  
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "image/png" = ["${image}"];
      "image/jpeg" = ["${image}"];
      "image/tiff" = ["${image}"];
      "image/svg+xml" = ["${image}"];
      "video/x-matroska" = ["${video}"];
      "video/mp4" = ["${video}"];
      "audio/mpeg" = ["${video}"];
      "application/json" = ["${text}"];
      "application/yaml" = ["${text}"];
      "application/pdf" = ["${pdf}"];
      "x-scheme-handler/magnet" = ["${torrent}"];
      "x-scheme-handler/http" = ["${browser}"];
      "x-scheme-handler/https" = ["${browser}"];
      "text/html" = ["${text}"];
    };
    defaultApplications = {
      "image/png" = ["${image}"];
      "image/jpeg" = ["${image}"];
      "image/tiff" = ["${image}"];
      "image/svg+xml" = ["${image}"];
      "video/x-matroska" = ["${video}"];
      "video/mp4" = ["${video}"];
      "audio/mpeg" = ["${video}"];
      "application/json" = ["${text}"];
      "application/yaml" = ["${text}"];
      "application/pdf" = ["${pdf}"];
      "x-scheme-handler/magnet" = ["${torrent}"];
      "x-scheme-handler/http" = ["${browser}"];
      "x-scheme-handler/https" = ["${browser}"];
      "text/html" = ["${text}"];
    };
  };

  home.file."user-dirs.dirs".target = ".config/user-dirs.dirs";
  home.file."user-dirs.dirs".text = ''
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run.
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
# 
XDG_SCREENSHOTS_DIR="$HOME/pictures/screenshots"
XDG_DOWNLOAD_DIR="$HOME/downloads"
XDG_MUSIC_DIR="$HOME/audio"
XDG_PICTURES_DIR="$HOME/pictures"
XDG_NEXTCLOUD_DIR="$HOME/nextcloud"
XDG_DESKTOP_DIR="$HOME/.default"
XDG_TEMPLATES_DIR="$HOME/.default"
XDG_PUBLICSHARE_DIR="$HOME/.default"
XDG_DOCUMENTS_DIR="$HOME/.default"
XDG_VIDEOS_DIR="$HOME/.default"
  '';

  home.file."user-dirs.locale".target = ".config/user-dirs.locale";
  home.file."user-dirs.locale".text = ''
en_US
  '';
}
