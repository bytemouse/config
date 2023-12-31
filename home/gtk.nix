{ nixosConfig, pkgs, lib, ...}:
{
  gtk = {
    enable = nixosConfig.setup.gui.enable;
    font = {
      name = "Hack Nerd Font";
      size = 11;
    };
    cursorTheme = {
      # the cursor theme has to be configure for certen programs to work
      # e.g. virt-manager won't be able to create vm's if it can't load the curos-theme
      package = pkgs.catppuccin-cursors.macchiatoBlue;
      name = "Catppuccin-Macchiato-Blue-Cursors";
      size = 16;
    };
    theme = {
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "macchiato";
      };
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };
}
