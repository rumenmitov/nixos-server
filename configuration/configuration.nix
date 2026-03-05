{ config, lib, pkgs, ... }:

{
	imports =
		[ 
			./hardware-configuration.nix
			./users.nix
			./networking.nix
		];

	nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

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

  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;

    logind.settings.Login.HandleLidSwitch = "ignore";
  };

  virtualisation = {
    containers.enable = true;

    docker = {
      enable = true;
    };
  };

	system.stateVersion = "25.11"; 
}

