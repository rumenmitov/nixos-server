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

	nixpkgs.config.allowUnfree = true;

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.grub.device = "nodev";

	time.timeZone = "Europe/Luxembourg";

	sound.enable = true;
	hardware.pulseaudio.enable = true;

	programs.zsh.enable = true;

	environment.systemPackages = with pkgs; [
			neovim 
			man-pages
			man-db
			curl
			git
			wget

			# Programming
			go
			rustup
	];


	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	services = {
		openssh.enable = true;
		logind.lidSwitch = "ignore";

		zerotierone = {
			enable = true;
			joinNetworks = [ "56374AC9A44F65A1" ];
		};
	};

	system.stateVersion = "24.05"; 
}

