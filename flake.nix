{
  description = "NIXOS Server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
  };

  outputs = { self, nixpkgs }: {

	nixosConfigurations."rumen-server" = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			./configuration/configuration.nix
		];
	};

  };
}
