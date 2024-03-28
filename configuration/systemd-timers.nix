{ pkgs, ... }:
{
	systemd.timers."system-backup" = {
		wantedBy = [ "timers.target" ];
		timerConfig = {
			OnCalendar = "Sun 14:00:00";
			Unit = "system-backup.service";
		};
	};

	systemd.services."system-backup" = {
		script = ''
			${pkgs.coreutils}/bin/rm -rf /snapshots/rumen-server/home-latest/
			${pkgs.btrfs-progs}/bin/btrfs subvolume snapshot /home /snapshots/rumen-server/home-latest
			'';
		serviceConfig = {
			Type = "oneshot";
			User = "root";
		};
	};
}
