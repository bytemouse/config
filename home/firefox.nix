{ pkgs, config ,... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  programs.firefox = {

    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          clearurls
          consent-o-matic
        ];
      };
    };
  };
}
