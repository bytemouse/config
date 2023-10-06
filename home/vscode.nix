{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      james-yu.latex-workshop
      valentjn.vscode-ltex
      catppuccin.catppuccin-vsc

      jnoortheen.nix-ide

    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "latex-utilities";
        publisher = "tecosaur";
        version = "0.4.11";
        sha256 = "0lnf2xvz3idzz2vihnd1246pcigqm90aannwmdb2bz9ayx96x0i8";
      }
      {
        name = "catppuccin-vsc-icons";
        publisher = "Catppuccin";
        version = "0.28.0";
        sha256 = "1jcvrxs1c3rgwmrinbmgspb3d8pshmz7wdins90cjrhplz906g1h";
      }
    ];
    userSettings = {
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.colorTheme" = "Catppuccin Macchiato";

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "nixpkgs-fmt";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = { "command" = [ "nixpkgs-fmt" ]; };
        };
      };
      "editor.formatOnSave" = true;
    };
  };
}

