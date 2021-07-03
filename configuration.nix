{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ./bluetooth.nix
      ./gui.nix
      ./chuwi.nix
      ./laptop.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "louis-lapbook";
  time.timeZone = "Europe/Paris";

  services.flatpak.enable = true;
  xdg.portal.enable = true; # needed for flatpak

  virtualisation.docker.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.louis = {
    isNormalUser = true;
    home = "/home/louis";
    extraGroups = [ "wheel" "video" "audio" "docker" ]; # Enable ‘sudo’ for the user.
  };

  users.users.sylvain = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ 
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0xv9D2ytKzxCErVyITLo3jfiDU3O7kLOg42qhSnWJ/yEtuxM3h2y7W3uQ/Nv2FqFE9rpF6es5rmfTqQ9x064ADWKhqeVmGQuUlTcs4NLZ7sISUfSRO6b5lD7UGLWZNTgR/aFpmgIfZzwXGDFavFeGZHWrVdB9Jic+3Xwcej57wUhGRQOvSsiA/BA+naAbf8oj+HKGNRa+ZWX1YRstJwsnlRsmc4W1ugHtRKMrvTZnDZpH/wpRJTSMAuuv/ZDihwM5S97HgQ0zp1UNUTWSr+8RuufVYMEbLGp9Bcf3Sr1l9KzFrPcGw5vDTT+C5p9f8EbWjjdGhl/ukqEf4KSOBU2X+pkKZr05m66kxwTU8gVjg1hCAhuxYyja6AODfgseNzOgIP9gFI5kycjVPGGsdYeZK6bCPoqQPqMBA1x6h9R2aMDW8tqcHdfnroS67rDs/tu8qL6IaH+tGDZNsPC8Kt28+IggbevDFqLjEN87RQK4XQF3h2TxgYbbeAB/62g31i8= sylvain@sylvain" 
    ];
  };

  environment.systemPackages = with pkgs; [
    home-manager
    picom
    wget
    ranger
    vim
    firefox
    termite
    bat
    vlc
  ];

  fonts.fonts = with pkgs; [
    siji
    fantasque-sans-mono
  ];
  fonts.fontconfig.allowBitmaps = true;
  fonts.fontconfig.useEmbeddedBitmaps = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

