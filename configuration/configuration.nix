{ config, lib, pkgs, ... }:

{
	imports =
		[ 
			./hardware-configuration.nix
			./users.nix
			./networking.nix
			./nextcloud.nix
			./systemd-timers.nix
		];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.grub.device = "nodev";

	time.timeZone = "Europe/Luxembourg";

	sound.enable = true;
	hardware.pulseaudio.enable = true;

	environment.systemPackages = with pkgs; [
			neovim 
			man-pages
			man-db
			curl
			git
			wget
	];


	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	services = {
		openssh.enable = true;
		logind.lidSwitch = "ignore";
	};

	system.stateVersion = "23.11"; 
}

