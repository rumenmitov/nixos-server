{
  description = "NIXOS Server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {

	nixosConfigurations."haven" = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			./configuration/configuration.nix
		];
	};

  };
}
