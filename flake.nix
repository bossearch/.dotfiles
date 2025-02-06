{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Keep Home Manager in sync with nixpkgs
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }@inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux"; # Change this if you're using ARM (e.g., a Raspberry Pi)

  in {
    # Define configurations for each host
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop/configuration.nix # Load system config
          home-manager.nixosModules.home-manager # Enable Home Manager as a NixOS module
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.bosse = import ./hosts/desktop/home.nix; # User config
          }
        ];
      };

      # laptop = lib.nixosSystem {
      #   inherit system;
      #   modules = [
      #     ./hosts/laptop/configuration.nix
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.users.bosse = import ./hosts/laptop/home.nix;
      #     }
      #   ];
      # };

      vm = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/vm/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bosse = import ./hosts/vm/home.nix;
          }
        ];
      };
    };
  };
}
