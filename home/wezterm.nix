{ config, nixosConfig, ... }:
let
  t = nixosConfig.theme.colours;
in
{

  programs.wezterm = {

    enable = nixosConfig.setup.gui.desktop.enable;

    colorSchemes = {

      default = {
        ansi = [
          t.surface1
          t.red
          t.green
          t.yellow
          t.darkBlue
          t.pink
          t.cyan
          t.subtext1
        ];
        background = t.bg;
        brights = [
          t.surface2
          t.red
          t.green
          t.yellow
          t.darkBlue
          t.pink
          t.cyan
          t.subtext0
        ];
        compose_cursor = t.lightPink;
        cursor_bg = t.pink;
        foreground = t.text;
        scrollbar_thumb = t.surface2;
        selection_bg = t.surface2;
        selection_fg = t.text;
        split = t.overlay0;
        visual_bell = t.surface0;

        indexed = {
          "16" = t.orange;
          "17" = t.white;
        };

        tab_bar = {
          background = t.black;
          inactive_tab_edge = t.surface0;
        };

        tab_bar.active_tab = {
          bg_color = t.purple;
          fg_color = t.black;
          intensity = "Normal";
          italic = false;
          strikethrough = false;
          underline = "None";
        };

        tab_bar.inactive_tab = {
          bg_color = t.bgDark;
          fg_color = t.text;
          intensity = "Normal";
          italic = false;
          strikethrough = false;
          underline = "None";
        };

        tab_bar.inactive_tab_hover = {
          bg_color = t.bg;
          fg_color = t.text;
          intensity = "Normal";
          italic = false;
          strikethrough = false;
          underline = "None";
        };

        tab_bar.new_tab = {
          bg_color = t.surface0;
          fg_color = t.text;
          intensity = "Normal";
          italic = false;
          strikethrough = false;
          underline = "None";
        };

        tab_bar.new_tab_hover = {
          bg_color = t.surface1;
          fg_color = t.text;
          intensity = "Normal";
          italic = false;
          strikethrough = false;
          underline = "None";
        };

      };

    };

    extraConfig = ''
      return {
        font = wezterm.font("Fira Mono Nerd Font"),
        font_size = 12.0,
        color_scheme = "default",
        hide_tab_bar_if_only_one_tab = true
      }
    '';

  };

}
