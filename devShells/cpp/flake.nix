
{
  description = "Flake for development with C++";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ags, ... }@inputs: let
	system = "x86_64-linux";
  in {

	#nixpkgs.config.allowUnfree = true;

	# Set up devshells
	devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
		buildInputs = with nixpkgs; [
			clang
		];

		#shellHook = "Running AGS shell";
	};

	# Main Config

  };
}
