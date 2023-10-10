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

  "pi-server" = {
    system = "aarch64-linux";
  };



}
