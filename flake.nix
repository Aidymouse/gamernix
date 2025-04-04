{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	home-manager.inputs.nixpkgs.follows = "nixpkgs";
	ags.url = "github:aylur/ags";
  };

  outputs = { self, nixpkgs, home-manager, ags, ... }@inputs: let
	system = "x86_64-linux";
  in {

	#nixpkgs.config.allowUnfree = true;


	# Main Config
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
		specialArgs = {
			pkgs = import nixpkgs { system=system; config.allowUnfree = true; };
		};
		modules = [
			./config.nix

			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.users.aidan = import ./home.nix;
			}
		];
	};

  };
}
