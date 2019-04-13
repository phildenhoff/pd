{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    latte-dock
    feh
    spotify
    typora
  ];

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

  programs.ssh.enable = true;
  programs.vscode.enable = true;
  programs.zsh = {
    enable = true;
    history.ignoreDups = true;
    initExtra = ''
      setopt HIST_IGNORE_ALL_DUPS
    '';
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [ "git" "sudo" ];
    oh-my-zsh.theme = "robbyrussell";
    shellAliases = {
      grep = "rg";
      find = "fd";
    };
  };
}
