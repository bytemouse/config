{ pkgs, unstable, ... }:

{

  environment.systemPackages = with pkgs; [

    pciutils
    ripgrep
    smartmontools
    rclone
    xdg-utils
    git-crypt
    neofetch
    wget
    gdb
    duf
    gdu
    nload
    gitui
    lua
    qrencode
    fast-ssh
    lm_sensors
    nix-output-monitor
    zfxtop
    fd
    libqalculate
    sshfs
    unzip
    nil
    nixpkgs-fmt
    duperemove
  ];

}
