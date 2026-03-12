{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwl-source = {
      url = "github:djpohly/dwl";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.kosmos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./kosmos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.adrian = import ./kosmos/home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
