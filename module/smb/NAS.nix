{
  fileSystems."/mnt/NAS" = {
    device = "//192.168.178.205/mitchel";
    fsType = "cifs";
    options = let automount_opts =
      "x-systemd.automount,noauto,x-systemd.idle.timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/home/mitchel/samba-cred/NAS-secrets,uid=mitchel"];
  };
}
