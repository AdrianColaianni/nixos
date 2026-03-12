{ config, pkgs, ... }:

{ networking.hosts = {
  "10.5.1.1" = ["colaianni.us" "mail.colaianni.us"];
  "10.5.1.2" = ["rathaus.red"];
  "10.5.1.3" = ["bigmac.colaianni.us"];
  "10.5.1.9" = ["aerial"];

  "10.6.1.1" = ["axt1800"];
  "10.6.1.3" = ["radon"];
  "10.6.1.4" = ["talos"];
  "10.6.1.5" = ["lunik"];

  "10.1.1.11" = ["equation-group"];
  "10.1.1.12" = ["lazarus"];
  "10.1.1.13" = ["zirconium"];
  "10.1.1.14" = ["fancy-bear"];

  "10.7.2.2" = ["dom-pi"];

  "10.7.3.1" = ["mt6000"];
};
}
