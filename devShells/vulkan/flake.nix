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
		# packages = [
		# 	pkgs.vulkan-headers
		# ];

		buildInputs = with pkgs; [
			gcc
			libclang
			clang-tools
			#glibc
			cmake
			sdl3

			shaderc
			vulkan-headers
			vulkan-loader
			vulkan-validation-layers
			vulkan-tools-lunarg
			vulkan-tools
			glfw3
			#X11
		];

		# LD_LIBRARY_PATH="${pkgs.glfw}/lib:${freetype}/lib:${vulkan-loader}/lib:${vulkan-validation-layers}/lib";
		VULKAN_SDK = "${pkgs.vulkan-headers}";
		VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
		#shellHook = "Running AGS shell";
	};

	# Main Config

  };
}
