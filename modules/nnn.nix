{ config, pkgs, ... }:
let
  # NNN colours - catppuccin
  # https://github.com/catppuccin/catppuccin/discussions/1955#discussion-4904597
  BLK = "03";
  CHR = "03";
  DIR = "04";
  EXE = "02";
  REG = "07";
  HARDLINK = "05";
  SYMLINK = "05";
  MISSING = "08";
  ORPHAN = "01";
  FIFO = "06";
  SOCK = "03";
  UNKNOWN = "01";
in
{



  environment.systemPackages = with pkgs; [
    (nnn.override { withNerdIcons = true; })
  ];

  environment.sessionVariables = {
    # https://github.com/catppuccin/catppuccin/discussions/1955#discussion-4904597
    NNN_COLORS = "#04020301;4231";
    NNN_FCOLORS = "${BLK}${CHR}${DIR}${EXE}${REG}${HARDLINK}${SYMLINK}${MISSING}${ORPHAN}${FIFO}${SOCK}${UNKNOWN}";
    NNN_ICONLOOKUP = if config.setup.gui.enable == true then "1" else "0";
    NNN_FIFO = "/tmp/nnn.fifo";
  };

}
