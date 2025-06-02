{
  description = "Flake for development with C++";

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
			gcc
			libclang
			clang-tools
			#glibc
			cmake
			sdl3

			shaderc,
			vulkan-headers
			vulkan-loader
			glfw3
			#X11
		];

		#shellHook = "Running AGS shell";
	};

	# Main Config

  };
}
