# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./software-dev.nix
      ./entertainment.nix
    ];

  # Enable zsh autocompletion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "casino"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
    };
  };

  time.timeZone = "America/Vancouver";

  environment.systemPackages = with pkgs; [
    wget
    vim
    tmux
    firefox

    redshift-plasma-applet
    redshift
    unzip
    zip
    ark
    git
    kgpg
    fd
    ripgrep
    xclip
    dropbox
    plasma-browser-integration

    xdg-desktop-portal-kde # open / save file dialogue
  ];

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      noto-fonts-cjk
      twemoji-color-font
    ];
  };

  fonts.fontconfig.penultimate.enable = false;

  nixpkgs.config.allowUnfree = true; 

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  hardware.bluetooth.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable zsh
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.phil = {
    home = "/home/phil";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
