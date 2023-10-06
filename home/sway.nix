{ nixosConfig, unstable, config, pkgs, lib, ...}:
let
  term-font-size = if nixosConfig.setup.screen == "big" then ''
    --config font_size=16.0
  '' else "";
  mod = config.wayland.windowManager.sway.config.modifier;
  secondLayout = if nixosConfig.setup.keyboard == "us" then "de" else "us";
  outputConfig = if nixosConfig.setup.screen == "big" then {
    "*".bg = "${nixosConfig.theme.colours.bg} solid_color";
    "DP-1".pos = "0 0 res 3840x2160";
    "HDMI-A-1".pos = "3840 0 res 3840x2160";
  } else {
    "*".bg = "${nixosConfig.theme.colours.bg} solid_color";
    "eDP-1".mode = "1920x1080 position 0,0 scale 1";
  };
  t = nixosConfig.theme.colours;
in
lib.mkIf nixosConfig.setup.gui.desktop.enable {

  wayland.windowManager.sway = {
    enable = true;
    
    config = {
    
      modifier = "Mod4";
      
      bars = [ { command = "waybar"; } ];
      
      colors = {
      
        focused = {
          background = t.bg;
          border = t.purple;
          childBorder = t.purple;
          indicator = t.purple;
          text = t.text;
        };

        focusedInactive = {
          background = t.bg;
          border = t.blue;
          childBorder = t.blue;
          indicator = t.blue;
          text = t.text;
        };
        
        unfocused = {
          background = t.bg;
          border = t.cyan;
          childBorder = t.cyan;
          indicator = t.cyan;
          text = t.text;
        };
        
        urgent = {
          background = t.bg;
          border = t.red;
          childBorder = t.red;
          indicator = t.red;
          text = t.text;
        };
        
        placeholder = {
          background = t.bg;
          border = t.black;
          childBorder = t.black;
          indicator = t.black;
          text = t.text;
        };

      };

      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        titlebar = false;
        border = 2;
      };

      defaultWorkspace = "workspace number 1";

      output = outputConfig; 

      input."*" = { 
        xkb_layout = "de";
        xkb_options = "us";
      };

      gaps.inner = 0;

      keybindings = {

        # Exit Sway 
        "${mod}+Shift+e" = "exit";
        
        # Screenshots
        "Print+w" = "exec grimshot save window"; 
        "Print+c" = "exec grimshot save area";
        "Print+a" = "exec grimshot save screen";

        # Display Bridness
        "XF86MonBrightnessDown" =  "exec light -U 5";
        "XF86MonBrightnessUp" = "exec light -A 5";

        # Swaylock
        "${mod}+Escape" = "exec swaylock";

        # Browser
        "${mod}+u" = "exec librewolf";

        # SwayNotificationCenter
        "${mod}+n" = "exec swaync-client -t -sw";
        
        # Volume
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

        # Terminal 
        "${mod}+i" = "exec ${pkgs.wezterm}/bin/wezterm ${term-font-size}";

        # Kill focused window 
        "${mod}+Shift+q" = "kill"; 
        
        # Start your launcher 
        "${mod}+p" = ''exec wofi --show=run --prompt="" --height=15% --width=25% --term=wezterm'';

        # MPD/MPC
        "XF86AudioPlay" = if nixosConfig.setup.screen == "big" then "exec mpc toggle" else null;
        "XF86AudioNext" = if nixosConfig.setup.screen == "big" then "exec mpc next" else null;
        "XF86AudioPrev" = if nixosConfig.setup.screen == "big" then "exec mpc prev" else null;
        "${mod}+m" = if nixosConfig.setup.screen == "small" then "exec mpc toggle" else null; 


        # Focus
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Moving
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Workspaces
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # Moving workspaces between outputs
        "${mod}+Control+Left" = "move workspace to output left";
        "${mod}+Control+Down" = "move workspace to output down";
        "${mod}+Control+Up" = "move workspace to output up";
        "${mod}+Control+Right" = "move workspace to output right";

        # Splits
        "${mod}+b" = "splith";
        "${mod}+v" = "splitv";

        # Layouts
        "${mod}+s" = "layout stacking";
        "${mod}+t" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+f" = "fullscreen toggle";

        "${mod}+Shift+a" = "focus parent";

        "${mod}+Control+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        # Scratchpad
        "${mod}+Shift+minus" = "move scratchpad";
        "${mod}+minus" = "scratchpad show";

        # Resize mode
        "${mod}+r" = "mode resize";

        # Reload Sway Configuration
        "${mod}+Shift+c" = "reload";
      };

      startup = [
        { command = "swaync"; always = true; }
      ];

    };
  
  };

  home.packages = with pkgs; [
    wev
    sway-contrib.grimshot
    wdisplays
    wl-clipboard
    unstable.swaynotificationcenter
  ];

}
