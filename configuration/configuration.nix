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

    ollama = {
      enable = true;
      host = "0.0.0.0";
    };

    paperless = {
      enable = true;
      passwordFile = "/etc/nixos/secrets/paperless/admin-pass";
      address = "0.0.0.0";
      dataDir = "/data/paperless";
      settings = {
        PAPERLESS_URL = "https://paperless.rumenmitov.duckdns.org";
      };
    };
  };

  security.acme.defaults.email = "rumenmitov@protonmail.com";
  security.acme.acceptTerms = true;

  virtualisation.containers.enable = true;
  virtualisation = {
    docker = {
      enable = true;
    };
  };

	system.stateVersion = "25.05"; 
}

