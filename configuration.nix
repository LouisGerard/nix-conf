{ config, pkgs, ... }:
let
  myCustomLayout = pkgs.writeText "xkb-layout" ''
    keycode 104 = Return
  '';
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "louis-lapbook";

  time.timeZone = "Europe/Paris";

  networking.interfaces.wlp1s0.useDHCP = true;

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        # todo rofi & polybar
        i3status
        i3lock
        polybar
        rofi
      ];
    };
  };
  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  virtualisation.docker.enable = true;

  services.xserver.libinput.enable = true;
  services.xserver.libinput.middleEmulation = true;
  services.xserver.libinput.tapping = true; 

  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}";

  programs.light.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel
  '';

  users.users.louis = {
    isNormalUser = true;
    home = "/home/louis";
    extraGroups = [ "wheel" "video" "audio" "docker" ]; # Enable ‘sudo’ for the user.
  };

  environment.systemPackages = with pkgs; [
    wget vim
    firefox
    termite
    bat
    vlc
  ];

  fonts.fonts = with pkgs; [
    fantasque-sans-mono
  ];

  networking.wireless.enable = true;
  networking.wireless.networks = {
    "SFR-8e10_5GHz" = {
      psk = "QCLPCMF4M2M1";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

