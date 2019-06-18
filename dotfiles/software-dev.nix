{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    rustup
    jdk
    gradle
    jetbrains.idea-ultimate
    insomnia
  ];

}
