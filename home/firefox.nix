{ nixosConfig, lib, ... }:
lib.mkIf nixosConfig.services.xserver.desktopManager.gnome.enable {

  programs.firefox = {
    enable = true;
    profiles."default" = {
      search.default = "DuckDuckGo";
      isDefault = true;
      settings = nixosConfig.home-manager.users.snd.programs.librewolf.settings;
    };
  };

}
