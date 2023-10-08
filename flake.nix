# TODO
# The repo needs to be dirty
# https://github.com/NixOS/nix/issues/8442
{

  description = "NixOS system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-unstable.url = "github:nix-community/home-manager";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

    nur.url = "github:nix-community/NUR";

    spicetify-nix.url = "github:the-argus/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , flake-utils
    , nixos-generators
    , ...
    }@inputs:

    {


      nixpkgs.hostPlatform = "x86_64-linux";

      # customize an existing format

      nixosConfigurations = nixpkgs.lib.mapAttrs
        (hostname: { system
                   , extraModules ? [ ]
                   , nixpkgs ? inputs.nixpkgs
                   , unstable ? inputs.nixpkgs-unstable.legacyPackages.${system}
                   }: nixpkgs.lib.nixosSystem rec {

          inherit system;

          specialArgs = {
            inherit inputs unstable;
          };

          modules = [
            (./machines + "/${hostname}")
            {
              nixpkgs = {
                config.allowUnfree = true;

              };
            }
          ] ++ (with inputs; [
            sops-nix.nixosModules.sops
            nur.nixosModules.nur
            # Use newest home-manager for hosts that use unstable, otherwise there are conflicts
            (if nixpkgs == inputs.nixpkgs-unstable then home-manager-unstable else home-manager).nixosModules.home-manager
          ] ++ extraModules);

        })
        (import ./machines inputs);

    } // (flake-utils.lib.eachDefaultSystem (system: { }));

}
