{ ... }@inputs:
let
  hardware = inputs.nixos-hardware.nixosModules;
in
{

  "thinkpad" = {
    system = "x86_64-linux";
  };



}
