{
  description = "flake for enabling flakes";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};

  };

  outputs = inputs@{ self, home-manager, nixpkgs }: {
    nixosConfigurations = {
      vmware = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./hardware-configuration-vmware.nix
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
