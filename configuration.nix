# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.useOSProber = true;
  boot.kernelParams = [ "evdi" ];
  nixpkgs.config.allowUnfree = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  fonts.fonts = with pkgs; [
  	fira-code fira-mono
  ];
  services.clipmenu.enable = true;
  services.autorandr.enable = false;
  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
    videoDrivers = [ "nvidia" "displaylink" "modesetting" ];
    windowManager = { 
      xmonad = {
	enable = true;
	enableContribAndExtras = true;
	extraPackages = hpkgs: [
	  hpkgs.xmobar
	];
      };
    };
    displayManager = {
      defaultSession = "none+xmonad";
      lightdm = {
	greeters.enso = {
	  enable = true;
	  blur = true;
	};
      };
      sessionCommands = ''
        xinput --map-to-output 'eGalax Inc. eGalaxTouch EXC3200-2505-09.00.00.00' DVI-I-1-1 &&
	    xrandr --setprovideroutputsource 1 0 &&
        xrandr --output DP2 --mode 2560x1440 --primary --rotate normal --output DP-0 --mode 1680x1050 --left-of DP-2 --rotate normal --output DVI-I-1-1 --mode 1920x1080 --rotate normal --right-of DP-2
      ''; 
    };
  };
  
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.semar = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      slack
      brave
      discord
      spotify
      vimPlugins.packer-nvim
      nerdfonts
      python39Packages.pip
    ];
  };
  # home-manager.users.semar = { pkgs, ... }: {};
  # home-manager.useUserPackages = true;
  # home-manager.enable = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    vim_configurable
    # neovim-nightly-unwrapped
    lua
    luajit
    rofi
    pandoc
    xclip
    zsh
    oh-my-zsh
    home-manager

    openssl
    # Terminals
    kitty
    alacritty
    xterm

    luajitPackages.luarocks
    pkgs.rnix-lsp
    starship
    picom
    fira-code
    git
    gimp
    tmux
    nodejs
    gnumake
    cmake
    yarn
    feh
    dmenu
    xwallpaper
    exa
    python3
    htop
    ripgrep
    cargo
    rustc
    rustup
    rustfmt
    rust-analyzer
    tree
    killall
    trayer
    sqlite
    pavucontrol
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    curl
    fzf
    gnupg
    jq
    nixpkgs-fmt
    sqlite
    nix-zsh-completions
    gcc
    pkgs._1password-gui
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      plugins = [ "git" "rust" "npm" "fzf" "colorize" "colorize-man-pages" "zsh-autosuggestions" "zsh-autocomplete" ];
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
  };
  
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";


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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

