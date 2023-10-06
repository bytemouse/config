{ ... }@inputs:
let
  hardware = inputs.nixos-hardware.nixosModules;
in
{

  "thinkpad" = {
    system = "x86_64-linux";
  };

  "desktop" = {
    system = "x86_64-linux";
  };

  "nixos-server" = {
    system = "x86_64-linux";
  };

  "nixos-pi" = {
    system = "aarch64-linux";
    extraModules = [
      hardware.raspberry-pi-4
    ];
  };


}
