{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    latte-dock
    feh # simple image viewer
    spotify
    typora
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
    path = "...";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  }; 

  services.redshift = {
    enable = true;
    latitude = "48.58";
    longitude = "-123.38";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.rofi = {
    enable = true;
    theme = "purple";
  };

  programs.vim = {
    enable = true;
    settings = {
      number = true;
      relativenumber = true;
      expandtab = true;
      tabstop = 4;
      shiftwidth = 4;
      ignorecase = true;
      smartcase = true;
      undofile = true;
    };
    extraConfig = ''
    set softtabstop=4
    set nocompatible
    nnoremap / /\v
    vnoremap / /\v

    " Searching, highlighting, etc
    set gdefault
    set incsearch
    set showmatch
    set hlsearch
    nnoremap <leader><space> :noh<cr>
    nnoremap <tab> %
    vnoremap <tab> %

    " Text wrapping
    set wrap
    set textwidth=90
    set formatoptions=qrn1
    set colorcolumn=85
    '';
  };

  programs.ssh.enable = true;
  programs.vscode.enable = true;
  programs.zsh = {
    enable = true;
    history.ignoreDups = true;
    initExtra = ''
      setopt HIST_IGNORE_ALL_DUPS
    '';
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [ "git" "sudo" "zsh-256color" "alias-tips" ];
    oh-my-zsh.theme = "sunrise";
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      grep = "rg";
      find = "fd";
      cls = "clear";
      here = "(dolphin . &) > /dev/null 2>&1";
      vcnix = "sudo vim /etc/nixos/configuration.nix";
      vhnix = "vim /home/phil/.config/nixpkgs/home.nix";
    };
  };

  programs.tmux = {
    enable = true;
    newSession = true;
    sensibleOnTop = true;
    terminal = "screen-256-color";
  };
}
