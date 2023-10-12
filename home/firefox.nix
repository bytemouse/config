{ nixosConfig, lib, ... }:
{
  programs.firefox = lib.mkIf nixosConfig.setup.gui.desktop.enable {
    enable = true;
    settings = {
      # enable firefox-sync
      "identity.fxaccounts.enabled" = true;
      "browser.uidensity" = 1;
      "browser.warnOnQuit" = false;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.sessionstore.resume_from_crash" = false; # starts a new session, when quiting with ctrl+q
    };
  };
}
