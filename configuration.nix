# Aityz's configuration.nix
# This Nix file describes my main daily-driver OS
# I personally prefer NixOS to Arch now, as you can hastily
# set up a minimal setup, without having to download everything
# based on memory, including stuff like Neovim, i3, xorg

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.device = "/dev/disk/by-label/boot";

  networking.hostName = "aityz";
  networking.networkmanager.enable = true; # personally I find nmcli really good

  services.automatic-timezoned.enable = true; # automatic time zone settings

  i18n.defaultLocale = "en_US.UTF-8";

  # I use the i3 Window Manager, which requires x11.
  # Although I am planning to switch to Hyprland
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  # Here, I enable i3
  services.xserver.windowManager.i3.enable = true;

  # Picom is needed for transparency
  services.picom.enable = true;

  /*
    Like I said, I will probably use Hyprland in the future
    
    programs.hyprland.enable = true;
  */

  # Btw I use Neovim
  programs.neovim.defaultEditor = true;
  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;

  # Try and enable sound
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    neovim # I use Neovim btw
    mesa # Useful drivers etc
    rofi # Drun, but looks nice
    kitty # Kitty terminal

    # Rust is my favorite programming language 
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy

    python3 # Python, for fast scripting
    fastfetch # How else will I flex my NixOS???
    polybar # Looks really good
    nerdfonts # I prefer Hack Nerd Font
  ];

  # OpenGL to open Kitty etc
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Oh My Zsh is extremely important, as it makes the shell look *so* nice
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "python" "man" ];
    theme = "agnoster";
  };

  # Git is like the most important thing ever
  programs.git = {
    enable = true;
    config = {
      user.name = "Aito Murai";
      user.email = "aito@outlook.com.au";
    };
  };

  # Set Zsh as default

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;


  networking.firewall.enable = false; # I don't need the NixOS firewall

  system.copySystemConfiguration = true; # backup configuration.nix

  system.stateVersion = "24.05";

}

