# jpselby.co.uk/projects/firefox-in-a-container

{pkgs, lib, config, ...}:
with lib;
with builtins;

let firefox-xinit = pkgs.writeShellScriptBin "firefox-xinit"
''
${pkgs.firefox}/bin/firefox &
exec ${pkgs.openbox}/bin/openbox
'';

in {
    config = {
        networking.nat = {
            enable = true;
            internalInterfaces = ["ve-+"];
            externalInterface = "wlp3s0";
        };

        containers.firefox-vnc = {
            ephemeral = true;
            autoStart = false;
            privateNetwork = true;
            hostAddress = "192.168.100.10";
            localAddress = "192.168.100.11";

            config = { config, pkgs, ... }: {
                system.stateVersion = "22.05";
                networking.firewall.allowedTCPPorts = [ 6080 ];

                users.users.firefox = {
                    home = "/home/firefox";
                    useDefaultShell = true;
                    isNormalUser = true;
                };

                systemd.services.tiger-vnc = {
                    wantedBy = ["multi-user.target"];
                    serviceConfig = {
                        ExecStart = ''${pkgs.xorg.xinit}/bin/xinit ${firefox-xinit}/bin/firefox-xinit -- ${pkgs.tigervnc}/bin/Xvnc :1 SecurityTypes=None'';
                        User = "firefox";
                    };
                };

                systemd.services.no-vnc = {
                    wantedBy = ["multi-user.target"];
                    path = [ pkgs.ps pkgs.hostname ];
                    serviceConfig = {
                        ExecStart = ''${pkgs.novnc}/bin/novnc --vnc localhost:5901'';
                        User = "firefox";
                    };
                };

                environment.systemPackages = with pkgs; [
                    openbox
                    firefox
                    firefox-xinit
                    novnc
                    tigervnc
                    xorg.xrandr
                    xorg.xinit
                ];
            };
        };
    };
}
