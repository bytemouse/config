{ nixosConfig, config, pkgs, lib, ...}:

let 
  t = nixosConfig.theme.colours;
  font-size = if nixosConfig.setup.screen == "big" then "20" else "14";
in

lib.mkIf config.wayland.windowManager.sway.enable {

  programs.wofi = {
    enable = true;
    style = ''
      #window {
      margin: 0px;
      border: none;
      background-color: transparent;
      }

      #input {
      font: Hack Nerd Font;
      font-size: ${font-size}px;
      margin: 0px;
      border: none;
      background-color: transparent;
      color: ${t.text};
      } 

      #inner-box {
      margin: 0px;
      border: none;
      background-color: ${t.bg};
      }

      #outer-box {
      margin: 0px;
      border: 2px solid ${t.red};
      background-color: ${t.bg};
      }

      #scroll {
      margin: 0px;
      border: none;
      background-color: transparent;
      }

      #text {
      font: Hack Nerd Font;
      font-size: ${font-size}px;
      color: ${t.text};
      margin: 5px;
      border: none;
      }

      #entry:selected {
      background-color: transparent;
      color: transparent;
      border: none;
      }

      #text:selected {
      font: Hack Nerd Font;
      font-size: ${font-size}px;
      color: ${t.blue};
      background-color: transparent;
      border: none;
      }
    '';
  };

}
