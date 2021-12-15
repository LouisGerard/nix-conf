{ config, pkgs, ... }:

let
  cfg = import ./config.nix { pkgs = pkgs; };
in
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./bluetooth.nix
    ./gui.nix
    ./laptop.nix
    ./sound.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = cfg.name;
  time.timeZone = "Europe/Paris";

  services.flatpak.enable = true;
  xdg.portal.enable = true; # needed for flatpak

  # virtualisation.docker.enable = true;

  users.users.louis = {
    isNormalUser = true;
    home = "/home/louis";
    extraGroups = [ "wheel" "video" "audio" "docker" ];
  };

  services.fstrim = { enable = true; };

  environment.systemPackages = with pkgs; [
    home-manager
    fontconfig
    wget
    killall
    tree
    alsaUtils
    vim
    termite
    bat
    vlc
    neofetch
  ];

  services.picom = {
    enable = true;
    vSync = true;
    backend = "glx";
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  fonts.fonts = with pkgs; [
    siji
    fantasque-sans-mono
  ];
  fonts.fontconfig.allowBitmaps = true;
  fonts.fontconfig.useEmbeddedBitmaps = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

