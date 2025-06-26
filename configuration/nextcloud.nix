{ config, pkgs, ... }:
{
  services.nextcloud = {
  	enable = true;
	hostName = "localhost";
	settings.trusted_domains = [ "192.168.194.151" ];
	https = false;
	configureRedis = true;
	package = pkgs.nextcloud31;
	config.adminpassFile = "/etc/nixos/secrets/nextcloud.env";
	config.dbtype = "sqlite";
  };
}
