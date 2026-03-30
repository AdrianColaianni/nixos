{ config, pkgs, dwl-source, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      dwl = super.dwl.overrideAttrs (oldAttrs: rec {
        src = dwl-source;
        patches = [
          ./programs/dwl/patches/autostart.patch
        ];
      });
    })
  ];
}
