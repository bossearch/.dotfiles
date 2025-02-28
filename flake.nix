{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    overlays = import ./modules/overlays.nix { inherit inputs; };
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
      overlays = overlays.overlays;
    };
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    # Define configurations for each host
    nixosConfigurations = {
      pc = lib.nixosSystem {
        inherit system;
        modules = [./hosts/pc/configuration.nix];
      };

      vm = lib.nixosSystem {
        inherit system;
        modules = [./hosts/vm/configuration.nix];
      };
    };

    # Standalone Home Manager Configurations
    homeConfigurations = {
      "bosse@pc" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs pkgs-unstable;
          hostName = "pc";
        };
        modules = [./hosts/pc/home.nix];
      };

      "bosse@vm" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs pkgs-unstable;
          hostName = "vm";
        };
        modules = [./hosts/vm/home.nix];
      };
    };

    # run install.sh for laziness
    packages.${system} = {
      default = self.packages.${system}.install;

      install = pkgs.writeShellApplication {
        name = "install";
        runtimeInputs = with pkgs; [git];
        text = ''${./scripts/install.sh} "$@"'';
      };
    };
    apps.${system} = {
      default = self.apps.${system}.install;

      install = {
        type = "app";
        program = "${self.packages.${system}.install}/bin/install";
      };
    };
  };
}
