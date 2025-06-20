
{
  description = "Flake for development with Typst";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: let
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
  in {

	#nixpkgs.config.allowUnfree = true;

	# Set up devshells
	devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
		buildInputs = with pkgs; [
			typst
			tinymist
			# libclang
			# cmake
			#X11
			python313Packages.python-lsp-server
		];

		#shellHook = "Running AGS shell";
	};

	# Main Config

  };
}
