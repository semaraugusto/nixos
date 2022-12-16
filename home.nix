{ config, pkgs, ... }:

{
  # imports = [
  #   ./programs/kitty.nix
  #   ./programs/fish
  #   ./programs/vim
  # ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # services.picom.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "semar";
  home.homeDirectory = "/home/semar";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    withPython3 = true;
    extraConfig = ''
      ${builtins.readFile /home/semar/.config/nvim/init.vim}
    '';

    extraPackages = with pkgs; [
      tree-sitter
      vimPlugins.nvim-lspconfig
      vimPlugins.plenary-nvim
      vimPlugins.lsp_extensions-nvim
      vimPlugins.lspkind-nvim
      vimPlugins.editorconfig-nvim
      vimPlugins.nvim-notify
      vimPlugins.undotree
      vimPlugins.nvim-cmp
      vimPlugins.cmp-cmdline
      vimPlugins.cmp-buffer
      vimPlugins.cmp-path
      vimPlugins.cmp-nvim-lua
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-nvim-lsp-document-symbol
      vimPlugins.cmp_luasnip
      vimPlugins.cmp-zsh
      vimPlugins.cmp-copilot
      vimPlugins.rust-tools-nvim
      vimPlugins.vim-crates
      # vimPlugins.vim-circom-syntax
      vimPlugins.nvim-dap
      vimPlugins.packer-nvim
      vimPlugins.nvim-dap-ui
      vimPlugins.nvim-dap-virtual-text
      vimPlugins.telescope-dap-nvim
      vimPlugins.nvim-dap-python
      tree-sitter-grammars.tree-sitter-lua
      vimPlugins.comment-nvim
      vimPlugins.vim-colorschemes



      luajitPackages.luarocks
      pkgs.rnix-lsp
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.vim-language-server
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.intelephense
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.yaml-language-server
      sumneko-lua-language-server
      texlab
      # rust-analyzer
      stylua
      nodePackages.prettier
      sqlite
      pkgs._1password-gui
    ];
  };

  # programs.git = {
  #   enable = true;
  #   userName = "Marcel Arie";
  #   userEmail = "googlillo@gmail.com";
  #   # aliases = { prettylog = "..."; };
  #   extraConfig = {
  #     core = {
  #       editor = "nvim";
  #     };
  #     color = {
  #       ui = true;
  #     };
  #     init = {
  #       defaultBranch = "main";
  #     };
  #     # push = { default = "simple"; };
  #     # pull = { ff = "only"; };
  #   };
  #   # ignores = [ ".DS_Store" "*.pyc" ];
  #   delta = {
  #     enable = true;
  #     options = {
  #       navigate = true;
  #       line-numbers = true;
  #       syntax-theme = "calochortus-lyallii";
  #     };
  #   };
  # };

  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Materia-dark";
  #     package = pkgs.materia-theme;
  #   };
  #   cursorTheme = {
  #     package = pkgs.paper-icon-theme;
  #     name = "Paper";
  #     size = 30;
  #   };
  #   iconTheme = {
  #     name = "Paper";
  #     package = pkgs.paper-icon-theme;
  #   };
  #   font = {
  #     name = "Noto Sans 9.5";
  #     package = pkgs.noto-fonts;
  #   };
  # };

  xdg.mimeApps = {
    enable = true;
    # associations.added = {
    #   "application/pdf" = [ "org.gnome.Evince.desktop" ];
    # };
    defaultApplications = {
      # "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };

  programs.rofi = {
    enable = true;
    font = "FiraCode 20";
    theme = ./programs/rofi/themes/slate.rasi;
  };

  home.packages = with pkgs;  [
    tcpdump
    firefox
    plocate
    termite
    alacritty
    kitty
    rustup
    pkg-config
    starship
    exa
    neofetch
    volumeicon
    haskellPackages.greenclip
    feh
    rofi
    pavucontrol
    unzip
    fzf
    fzy
    arandr
    autorandr
    bat
    ripgrep
    lua
    lua53Packages.luarocks
    python3
    fd
    gh
    python3
    nodejs
    rofi-power-menu
    webcamoid
    nixpkgs-fmt
    docker-compose
    libnotify
    rofimoji
    sysz
    tldr
    nix-prefetch-github
    xfce.xfce4-notifyd
    sumneko-lua-language-server
    discord
    python39Packages.pynvim
    jq
    yarn
    htop
    nodePackages.speed-test
    nodePackages.pnpm
    fzf
    brave

    # chromium
    # leftwm
    # chromium
    # dunst
    # update-systemd-resolved
    # openvpn
    # home-manager
    # fish
    # vim
    # cargo
    # sumneko-lua-language-server
  ];

  programs.java.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.05";
  # home.stateVersion = "20.09";
}
