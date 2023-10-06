{ config, pkgs, lib, ... }:
{
  options = with lib; with lib.types; {
    setup.ocr.enable = mkEnableOption "ocr";
  };

  config = lib.mkIf config.setup.ocr.enable {

    environment.systemPackages = with pkgs; [
      tesseract
      gnome-frog
      gImageReader # use scan mode 'hORC,PDF' to be able to export a pdf with an invisble text layer is difficult to find
      hunspell
    ];

  };

}
