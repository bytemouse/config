{ nixosConfig, config, ... }:
let
  t = nixosConfig.theme.colours;
in
{

  # NOTE: swaylock needs to be part of pam
  # https://github.com/swaywm/sway/issues/2773#issuecomment-427570877
  # i added it system/modules/programs.nix
  programs.swaylock = {
    enable = config.wayland.windowManager.sway.enable;
    settings = {
      
      font = nixosConfig.theme.font;
      font-size = 16;
      indicator-idle-visible = true;
      indicator-radius = 100;
      show-failed-attempts = true;

      # colours
      color = t.bg;
      
      bs-hl-color = t.red;
      
      caps-lock-bs-hl-color = t.red;
      caps-lock-key-hl-color = t.red;
      
      inside-color = t.bg;
      inside-clear-color = t.text;
      inside-caps-lock-color = t.text;
      inside-ver-color = t.text;
      inside-wrong-color = t.text;
      
      key-hl-color = t.red;
      
      layout-bg-color = t.bg;
      layout-border-color = t.bg;
      layout-text-color = t.text;
      
      line-color = t.white;
      line-clear-color = t.white;
      line-caps-lock-color = t.white;
      line-ver-color = t.white;
      line-wrong-color = t.white;
      
      ring-color = t.red;
      ring-clear-color = t.red;
      ring-caps-lock-color = t.red;
      ring-ver-color = t.red;
      ring-wrong-color = t.red;

      seperator-color = t.red;
      
      text-color = t.text;
      text-clear-color = t.bg;
      text-caps-lock-color = t.bg;
      text-ver-color = t.bg;
      text-wrong-color = t.bg;
    
    };
  };

}
