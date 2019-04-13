{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    multimc
  ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.screenSection = '' 
   Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    '';
}


