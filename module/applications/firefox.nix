{ pkgs, ... }:

{
    programs.firefox = {
        enable = true;

        policies = {
            Cookies = {
                "Behavior" = "reject-tracker-and-partition-foreign"; 
            };
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            EnableTrackingProtection = {
                Value = true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
            };
            DisablePocket = true;
            DisableFirefoxScreenshots = true;
            DontCheckDefaultBrowser = true;
            HardwareAcceleration = false;
            SearchBar = "unified";
            Preferences = {
                "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            };

            ExtensionSettings = {
                "*".installation_mode = "blocked";

                # Privacy Badger
                "jid1-MnnxcxisBPnSXQ@jetpack" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
                    installation_mode = "force_installed";
                };

                # uBlock Origin
                "uBlock0@raymondhill.net" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                    installation_mode = "force_installed";
                };

                # Sponsorblock
                "sponsorBlocker@ajay.app" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
                    installation_mode = "force_installed";
                };

                # User agent switcher
                "user-agent-switcher@ninetailed.ninja" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/uaswitcher/latest.xpi";
                    installation_mode = "force_installed";
                };
            };
        };
    };
}
