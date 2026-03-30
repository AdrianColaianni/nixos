{
  description = "Cannoli Net NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.54.2-b";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    dwl-source = {
      url = "github:djpohly/dwl";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations.kosmos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./kosmos/configuration.nix
        ./programs/dwl/dwl.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.adrian = import ./kosmos/home.nix;
            backupFileExtension = "backup";
          };
        }
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
      ];
    };
  };
}
