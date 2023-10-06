{ nixosConfig, config, pkgs, lib, ...}:
let
  b = nixosConfig.theme.colours.bg;
  theme = config.gtk.theme.name;
in
{ 
  config = lib.mkIf nixosConfig.services.xserver.desktopManager.gnome.enable {

    # Gnome Shell : https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/#gnome-extensions
    # solid colours : https://askubuntu.com/a/699567
    # https://www.reddit.com/r/NixOS/comments/11ry515/examples_of_theming_gnome_with_nix_the_right_way/
    # https://github.com/LongerHV/nixos-configuration/blob/21a13e22db2ac93525ca83b118e6b0b0c24f8872/modules/home-manager/myHome/gnome/default.nix
    dconf.settings = lib.mkIf nixosConfig.services.xserver.desktopManager.gnome.enable {
      "org/gnome/desktop/sound".event-sounds = false;
      "org/gnome/desktop/background" = {
        primary-color = b;
        secondary-color = b;
        picture-uri = "";
        picture-uri-dark = "";
        color-shading-type = "solid";
      };
      "org/gnome/desktop/screensaver" = {
        primary-color = b;
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = theme;
      };
      "org/gnome/desktop/a11y" = {
        always-show-universal-access-status = true; # on-screen-keyboard and other useful thing when in 'tablet mode'
      };
    };

    home.packages = with pkgs; [
      gnome.dconf-editor
      gnomeExtensions.user-themes
    ];

  };

}
