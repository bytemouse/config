{ nixosConfig, lib, ... }:
{
  programs.firefox = lib.mkIf nixosConfig.setup.gui.desktop.enable {
    enable = true;
    profiles."default" = {
      settings = {
        # enable firefox-sync
        isDefault = true;
        "identity.fxaccounts.enabled" = true;
        "browser.uidensity" = 1;
        "browser.warnOnQuit" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.sessionstore.resume_from_crash" = false; # starts a new session, when quiting with ctrl+q
      };
    };
  };
}
