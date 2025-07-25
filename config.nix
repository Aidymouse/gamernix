# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = ["nix-command" "flakes"];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

	hardware.bluetooth.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  networking = {
	  hostName = "groundspawn-nixos"; # Define your hostname.
	  # useDHCP = false; # Nevermind not true -> I think this does something to do with failing to reach servers on the first try?
	  networkmanager.enable = true;
	  networkmanager.insertNameservers = [ "1.1.1.1" "8.8.8.8"];
  };
	#  xdg.portal = {
	# enable = true;
	# #xdgOpenUsePortal = true;
	# extraPortals = [ 
	# 	pkgs.xdg-desktop-portal
	# 	#pkgs.xdg-desktop-portal-gtk 
	# 	pkgs.xdg-desktop-portal-wlr 
	# ];
	# config = {
	# 	common.default = ["wlr"];
	# };
	#  };

  # Auto mount USB apparently
  services.devmon.enable = true;
	services.gvfs.enable = true;
	services.udisks2.enable = true;
  # Enable network manager applet
  # programs.nm-applet.enable = true;
	programs.adb.enable = true;

	programs.sway.enable = true;

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_NZ.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LXQT Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.lxqt.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "nz";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

	programs.zsh = {
		enable = true;
	};
  # Define a user account. Don't forget to set a password with ‘passwd’.
	users = {
		defaultUserShell = pkgs.zsh;
		users.aidan = {
			shell = pkgs.zsh;
			isNormalUser = true;
			description = "aidan";
			extraGroups = [ "networkmanager" "wheel" "adbusers" ];
			packages = with pkgs; [
			#  thunderbird
			];
		};
	};

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "aidan";


	# Install firefox.
	# programs.firefox.enable = true;
	# programs.librewolf.enable = true;


	### Fonts
	fonts.packages = with pkgs; [
	#roboto
	nerd-fonts.fira-code
	nerd-fonts.bigblue-terminal
	nerd-fonts.departure-mono
	nerd-fonts.gohufont
	nerd-fonts.monofur
	nerd-fonts.mononoki
	#nerd-fonts.bigblueterm
	#bigblueterm
	];

	fonts.fontconfig = {
		enable = true;
	};
  # Allow unfree packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	neovim

	waybar
	wofi
	ags

	wirelesstools

	font-awesome

	# Needed to enable screenshots with Sway
	slurp
	wl-clipboard


	# gutenprint
	# cups
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

	environment.loginShellInit = ''
		sway
	'';
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
