{ inputs, unstable, pkgs, config, lib, ... }:
{

  home-manager.users.snd =
    { nixosConfig
    , config
    , pkgs
    , ...
    }: {
      home.stateVersion = "22.11";
      imports = [
        ./alacritty.nix
        ./git.nix
        ./gtk.nix
        # ./mail.nix
        ./mpv.nix
        ./ncmpcpp.nix
        ./sway.nix
        ./waybar.nix
        ./wofi.nix
        ./xdg.nix
        ./zathura.nix
        ./bat.nix
        ./cli-visuializer.nix
        ./mpd.nix
        ./zsh
        ./tmux.nix
        ./qt.nix
        ./spotify.nix
        ./ssh.nix
        ./sops.nix
        ./wezterm.nix
        ./nnn.nix
        ./swaylock.nix
        ./dconf.nix
        #./contacts_calendar.nix TODO
        ./easyeffetcs.nix
        ./gpg.nix

        ./swaync
        ./network-certs
        ./neovim.nix
        ./vscode.nix
      ];
    };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit unstable inputs; };

}
