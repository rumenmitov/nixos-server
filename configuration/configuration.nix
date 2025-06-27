{ config, lib, pkgs, ... }:

{
	imports =
		[ 
			./hardware-configuration.nix
			./users.nix
			./networking.nix
			./nextcloud.nix
		];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.grub.device = "nodev";


	time.timeZone = "Europe/Luxembourg";

	programs.zsh = {
		enable = true;
		autosuggestions = {
			enable = true;
			strategy = [ "completion" "history" ];
		};
	};


	environment.systemPackages = with pkgs; [
			man-pages
			man-db
			curl
			git
			wget
			wireguard-tools
			neovim

			# Programming
			go
			rustup
      cargo
	];

	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	services = {
		openssh.enable = true;
		logind.lidSwitch = "ignore";
	};

  security.acme.defaults.email = "rumenmitov@protonmail.com";
  security.acme.acceptTerms = true;

	system.stateVersion = "25.05"; 
}

