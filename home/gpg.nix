{ pkgs, ... }:
{

  programs.gpg = {
    enable = true;
    settings = {
      keyid-format = "LONG";
      with-fingerprint = true;
      with-keygrip = true;
    };
  };

  home.packages = with pkgs; [
    gpg-tui
  ];

}
