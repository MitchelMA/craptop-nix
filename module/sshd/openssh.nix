{ config, pkgs, lib, ... }:

{
    services.openssh = {
        enable = true;
        ports = [ 1001 ];
        settings = {
            PasswordAuthentication = true;
            AllowUsers = null;
            UseDns = true;
            X11Forwarding = false;
            PermitRootLogin = "prohibit-password";
        };
    };

    systemd.services.sshd.wantedBy = lib.mkForce [ ];

    networking.firewall.allowedTCPPorts = [ 1001 ];
}
