{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hosts.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kosmos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gcc
    zsh
    curl
    gzip
    unzip
    zip
    ripgrep
    dust
    wireguard-tools
    nps
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.noto
    nerd-fonts.commit-mono
    fira-code
    jost
    besley
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  programs.zsh.enable = true;
  
  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    jack.enable = true;
  };

  security.sudo.extraRules= [
    {  users = [ "adrian" ];
      commands = [ {
           command = "ALL" ;
           options= [ "NOPASSWD" "SETENV" ];
      } ];
    }
  ];

  users.users.adrian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      neovim
      tree
      brave
      waybar
      hypridle
      hyprlock
      signal-desktop
      evolution
      vesktop
      rose-pine-gtk-theme
      wl-clipboard
      rofi
      pass
      rofi-pass
      wtype
      passExtensions.pass-otp
      passExtensions.pass-genphrase
      zathura
      kitty
      eza
      sxiv
      fzf
      kdePackages.dolphin
      swaybg
      dunst
      xremap
      hyprshot
      brightnessctl
      tmux
      btop
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

}
