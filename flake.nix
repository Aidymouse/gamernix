{
  description = "flake for enabling flakes";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

	home-manager = {
		url = "github:nix-community/home-manager/release-23.11";
		inputs.nixpkgs.follows = "nixpkgs";
	};

  };

  outputs = inputs@{ self, home-manager, nixpkgs }: {
    nixosConfigurations = {
      flakeEn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

        
		home-manager.nixosModules.home-manager
		{
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;

			home-manager.users.aidan = import ./home.nix;
		}

	];
      };
    };
  };
}
