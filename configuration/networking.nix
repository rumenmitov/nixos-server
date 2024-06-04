{ ... }:
{

  networking = {
  	hostName = "rumen-server"; 
  	networkmanager.enable = true;  

	nat = {
		enable = true;
		externalInterface = "eth0";
		internalInterfaces = [ "wg0" ];
	};

  	firewall.enable = true;
  	firewall.allowedTCPPorts = [ 443 80 22 9993 ];
  	firewall.allowedUDPPorts = [ 443 80 22 9993 ];

  };
}
