{ config, pkgs, lib, ... }:
let 
  lv = config.virtualisation.libvirtd;
in
{

  options.setup = with lib; with lib.types; {
    extraArch.enable = mkEnableOption "ExtraArch";
    libvirt.autostart.enable = mkEnableOption "autostart libvirtd";
  };   

  config = {
    
    programs.dconf.enable = lib.mkDefault lv.enable; # required for virt-manager

    virtualisation = {
      
      libvirtd.qemu.ovmf.packages = lib.mkIf (lv.enable && lv.qemu.ovmf.enable) [ 
        pkgs.OVMFFull.fd
        pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd
      ];
      
      oci-containers.backend = lib.mkDefault "podman";

    };

    # To disable libvirtd autostart
    systemd.services.libvirtd.enable = lib.mkIf lv.enable config.setup.libvirt.autostart.enable;

    boot.binfmt.emulatedSystems = lib.mkIf config.setup.extraArch.enable [ "aarch64-linux" ];

    environment.systemPackages = lib.mkIf config.setup.gui.desktop.enable (with pkgs; [
      virt-manager
      virt-viewer
    ]);

  };

}
