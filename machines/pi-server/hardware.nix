{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      raspberryPi = {
        enable = true;
        version = 3;
      };
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_rpi3;
    tmpOnTmpfs = true;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" "vc4" ];
    # ttyAMA0 is the serial console broken out to the GPIO
    kernelParams = [
      "8250.nr_uarts=1"
      "console=ttyAMA0,115200"
      "console=tty1"
    ];

    # intird.network = {
    #   enable = true;
    #   ssh = {
    #     enable = true;
    #     port = 22;
    #     shell = "/bin/cryptsetup-askpass";
    #     authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINtVkqIQ8zNCSgImtlIH3Ldg4Xmt+Y7+xJmI+mDRkC8Q snd@thinkpa" ];
    #     hostKeys = [ "/etc/secrets/initrd/ssh_host_rsa_key" "/etc/secrets/initrd/ssh_host_ed25519_key" ];
    #   };
    # };
  };

  hardware = {
    # Required for the Wireless firmware
    enableRedistributableFirmware = true;
  };


}
