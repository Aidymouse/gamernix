{
  description = "Flake for development with AGS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	ags.url = "github:aylur/ags";
  };

  outputs = { self, nixpkgs, ags, ... }@inputs: let
	system = "x86_64-linux";
  in {

	#nixpkgs.config.allowUnfree = true;

	# Set up devshells
	devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
		buildInputs = [
			(ags.packages.${system}.default.override {
				#extraPackages = [];
			})
		];
	};

	# Main Config

  };
}
