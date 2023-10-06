{ pkgs, unstable, config, lib, ... }:
lib.mkIf config.setup.gui.desktop.enable {

  environment.systemPackages = with pkgs; [

    kotlin
    ghc # haskell-lsp can't work with a newer version
    cmake
    gcc
    clang
    cargo
    clippy
    maven

  ];

}
